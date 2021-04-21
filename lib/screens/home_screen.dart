import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

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

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _HomeScreenState extends State<HomeScreen> {
  logout() {
    AuthService.logout();
  }

  @override
  Widget build(BuildContext context) {
    //pop up dialog when completing the task
    createCongradulationDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Contradulations "),
              content: IconButton(icon: Icon(Icons.share), onPressed: () {}),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text("OK"),
                )
              ],
            );
          });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('habits')
                    .where('UserID', isEqualTo: uid)
                    .where('isCurrent', isEqualTo: true)
                    .snapshots(),
                // stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('isCurrent', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                              backgroundColor: Colors.grey)
                        ]);
                  }

                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data.documents[index];
                        return ListTile(
                          /*leading:
                          Icon(Icons.schedule, size: 40, color: Colors.blue),*/
                          // leading: CheckboxListTile(value: doc["isComplete"], onChanged: (input) => doc.reference.update({"isComplete": input}), controlAffinity: ListTileControlAffinity.leading),
                          title: Column(
                            children: <Widget>[
                              Text(doc["Title"]),
                              Text('Monday, Friday')
                            ],
                          ),
                          subtitle: IconButton(
                              icon: Icon(Icons.change_history),
                              iconSize: 40,
                              key: Key('complete-button'),
                              color: Colors.green,
                              onPressed: () {
                                createCongradulationDialog(context);
                              }),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.check_box), onPressed: null),
                              IconButton(
                                  icon: Icon(Icons.edit), onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('habits')
                                        .doc(doc.id)
                                        .delete();
                                  }),
                            ],
                          ),
                        );
                      });
                }),
          ),
          Container(
            //check of its a times or a number of complete
            height: 200,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('habits')
                    .where('UserID', isEqualTo: uid)
                    .where('isCurrent', isEqualTo: true)
                    .where('Time Based', isEqualTo: true)
                    .snapshots(),
                // stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('isCurrent', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                              backgroundColor: Colors.grey),
                          Text(
                            "There is no Primary Habit active",
                          )
                        ]);
                  }
                  //we will display the timer for the recording when click the complete button
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data.documents[index];
                        return ListTile(
                          /*leading:
                          Icon(Icons.schedule, size: 40, color: Colors.blue),*/
                          // leading: CheckboxListTile(value: doc["isComplete"], onChanged: (input) => doc.reference.update({"isComplete": input}), controlAffinity: ListTileControlAffinity.leading),
                          title: Column(
                            children: <Widget>[
                              Text(doc["Title"]),
                              Text('Monday, Friday')
                            ],
                          ),
                          subtitle: IconButton(
                              icon: Icon(Icons.change_history),
                              iconSize: 40,
                              key: Key('complete-button'),
                              color: Colors.green,
                              onPressed: () {
                                createCongradulationDialog(context);
                              }),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.check_box), onPressed: null),
                              IconButton(
                                  icon: Icon(Icons.edit), onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('habits')
                                        .doc(doc.id)
                                        .delete();
                                  }),
                            ],
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
