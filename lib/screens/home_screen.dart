import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

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
    "habitmade": "10:15 2/15/2020"
  },
  {
    "id": 1,
    "taskT": "Figure out duplication",
    "taskS": 20,
    "habitmade": "10:15 2/15/2020"
  },
  {"id": 2, "taskT": "Refactor", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 3,
    "taskT": "Add comments",
    "taskS": 35,
    "habitmade": "10:15 2/15/2020"
  },
  {"id": 4, "taskT": "commit code", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 5,
    "taskT": "push to github",
    "taskS": 50,
    "habitmade": "10:15 2/15/2020"
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: database.length,
          itemBuilder: (context, index) {
            total_habits += 1;
            return MyHabit((database[index]["id"]), (database[index]["taskT"]),
                (database[index]["taskS"]), (database[index]["habitmade"]));
          },
        ),
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

//this class makes a a show the two variables taken
class MyHabit extends StatefulWidget {
  //variables show to the User when in the homepage,
  int _id;
  String HabitTitle;
  int HabitTrack;
  String Timecomplete;
  //add any other things leave at 2 for now
  MyHabit(this._id, this.HabitTitle, this.HabitTrack, this.Timecomplete);
  @override
  _MyHabitState createState() => _MyHabitState();
}

// to display the habit info, title, time completed, amount of times completed.
//add a edit button for the habit
class _MyHabitState extends State<MyHabit> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    widget.HabitTitle,
                    style: new TextStyle(fontSize: 30.0),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditScreen()));
                      })
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text("${widget.Timecomplete}"),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.list),
                      onPressed: () {
                        // save habit info for next page
                        habitname = widget.HabitTitle;
                        total_complete = widget.HabitTrack;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HabitSummary()));
                      })
                ]),
              ),
              Text("we want to add a weekly calender, showing complete days"),
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
                        iconSize: 30,
                        color: Colors.blue,
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
