import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

import 'create_screen.dart';
import 'edit_screen.dart';

int total_habits = 5;

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _HomeScreenState extends State<HomeScreen> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: StreamBuilder
      (
        // stream: FirebaseFirestore.instance.collection('users').collection(uid).snapshots(),
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData)
          {
            return Text('Loading data. Please wait...');
          }
          return Column
          (
            children: <Widget>
            [
              Text(snapshot.data['email']),
              Text(snapshot.data['username']),
            ],
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

//this class makes a a show the two variables taken
class MyHabit extends StatefulWidget 
{
  //variables show to the User when in the homepage,
  int id;
  String HabitTitle;
  int HabitTrack;
  String Timecomplete;
  //add any other things leave at 2 for now
  MyHabit(this.id, this.HabitTitle, this.HabitTrack, this.Timecomplete);
  @override
  _MyHabitState createState() => _MyHabitState();
}

// to display the habit info, title, time completed, amount of times completed.
//add a edit button for the habit
class _MyHabitState extends State<MyHabit> 
{
  @override
  Widget build(BuildContext context) 
  {
    return new Container
    (
      child: Card
      (
        child: Padding
        (
          padding: const EdgeInsets.all(5.0),
          child: Column
          (
            children: <Widget>
            [
              Padding
              (
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>
                [
                  Text
                  (
                    widget.HabitTitle,
                    style: new TextStyle(fontSize: 30.0),
                  ),
                  Spacer(),
                  IconButton
                  (
                      icon: Icon(Icons.edit),
                      onPressed: () 
                      {
                        Navigator.push
                        (
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditScreen())
                        );
                      })
                ]),
              ),
              Padding
              (
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>
                [
                  Text("${widget.Timecomplete}"),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${widget.HabitTrack}",
                      style: new TextStyle(fontSize: 35.0),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            widget.HabitTrack += 1;
                            print(widget.HabitTrack);
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
