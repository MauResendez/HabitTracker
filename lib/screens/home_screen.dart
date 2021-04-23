import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:string_validator/string_validator.dart';

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

  bool startpressed = true;
  bool stoppressed = true;
  bool resetpressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      //when start time save date and save to database
      stoppressed = false;
      startpressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stoppressed = true;
      resetpressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      startpressed = true;
      resetpressed = true;
    });
    //save the total before deleting info and send to database;

    stoptimetodisplay = "00:00:00";
    swatch.reset();
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              stoptimetodisplay,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: stoppressed ? null : stopstopwatch,
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 15.0,
                      ),
                      child: Text("STOP"),
                    ),
                    RaisedButton(
                      onPressed: resetpressed ? null : resetstopwatch,
                      color: Colors.teal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 15.0,
                      ),
                      child: Text("RESET"),
                    )
                  ],
                ),
                SizedBox(),
                RaisedButton(
                  onPressed: startpressed ? startstopwatch : null,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 20.0,
                  ),
                  child: Text("START"),
                )
              ],
            ),
          )
        ],
      ),
    );
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
            child: Column(
              children: <Widget>[
                stopwatch(),
                Text("show the list of completions for this habit"),
                Text("hello there")
              ],
            ),
          )
        ],
      ),
    );
  }
}
