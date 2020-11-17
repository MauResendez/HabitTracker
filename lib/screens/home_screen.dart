import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'calendar_screen.dart';
import 'create_screen.dart';
import 'edit_screen.dart';
import 'habit_summary.dart';

int total_habits = 0;
String habitname;
Key habitID;
int total_complete;

List<Map<String, dynamic>> database = [
  {
    "id": 0,
    "taskT": "Understand Code",
    "taskS": 15,
    "habitmade": "10:15 11/15/2020"
  },
  {
    "id": 1,
    "taskT": "Figure out duplication",
    "taskS": 20,
    "habitmade": "10:15 11/12/2020"
  },
  {"id": 2, "taskT": "Refactor", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 3,
    "taskT": "Add comments",
    "taskS": 35,
    "habitmade": "10:15 11/13/2020"
  },
  {"id": 4, "taskT": "commit code", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 5,
    "taskT": "push to github",
    "taskS": 50,
    "habitmade": "10:15 11/15/2020"
  }
];

class HomeScreen extends StatefulWidget 
{
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _HomeScreenState extends State<HomeScreen> 
{
  logout() 
  {
    AuthService.logout();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: StreamBuilder
      (
        stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).snapshots(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData)
          {
            return CircularProgressIndicator(backgroundColor: Colors.black);
          }

          return ListView.builder
          (
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index)
            {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return ListTile
              (
                leading: Icon(Icons.schedule, size: 40, color: Colors.blue),
                // leading: CheckboxListTile(value: doc["isComplete"], onChanged: (input) => doc.reference.update({"isComplete": input}), controlAffinity: ListTileControlAffinity.leading),
                title: Text(doc["Title"]),
                subtitle: Text
                (
                  'Monday, Wednesday, Friday'
                ),
                trailing: Wrap
                (
                  spacing: 12, // space between two icons
                  children: <Widget>
                  [
                    IconButton(icon: Icon(Icons.edit), onPressed: () 
                    {

                    }),
                    IconButton(icon: Icon(Icons.delete), onPressed: ()
                    {
                      FirebaseFirestore.instance.collection('habits').doc(doc.id).delete();
                    }),
                  ],
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

