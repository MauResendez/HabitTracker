import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/create_screen.dart';
import 'package:habittracker/services/auth_service.dart';

class ListScreen extends StatefulWidget 
{
  @override
  _ListScreenState createState() => _ListScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _ListScreenState extends State<ListScreen> 
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
            return Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator(backgroundColor: Colors.grey)]
            );
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
                // leading: CheckboxListTile
                // (
                //   value: doc["isComplete"], 
                //   onChanged: (input) 
                //   {
                //     // doc.reference.update({"isComplete": input, "dailyCompletions": FieldValue.increment(1), "weeklyCompletions": FieldValue.increment(1), "monthlyCompletions": FieldValue.increment(1), "yearlyCompletions": FieldValue.increment(1), "streak": FieldValue.increment(1)});
                //     doc.reference.update({"isComplete": input});
                //     if(input == true)
                //     {
                //       doc.reference.update({"dailyCompletions": FieldValue.increment(1), "weeklyCompletions": FieldValue.increment(1), "monthlyCompletions": FieldValue.increment(1), "yearlyCompletions": FieldValue.increment(1), "streak": FieldValue.increment(1)});
                //     }
                //   }, 
                //   controlAffinity: ListTileControlAffinity.leading
                // ),
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
      floatingActionButton: FloatingActionButton
      (
        onPressed: () 
        {
          Navigator.push
          (
              context, MaterialPageRoute(builder: (context) => CreateScreen())
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
