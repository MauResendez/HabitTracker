import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

void initState() {}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class _CreateScreenState extends State<CreateScreen> {
  bool isCurrent = false; //abrahan had added to see if works when save habit
  bool isTimeBased = false;
  bool isBlind = false;
  bool isDeaf = false;
  bool forMonday = false;
  bool forTuesday = false;
  bool forWednesday = false;
  bool forThursday = false;
  bool forFriday = false;
  bool forSaturday = false;
  bool forSunday = false;
  bool wantNotifications = true;
  String habitTitle = "";

  final firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  createHabit() {
    Map<String, dynamic> days = {
      "Monday": forMonday,
      "Tuesday": forTuesday,
      "Wednesday": forWednesday,
      "Thursday": forThursday,
      "Friday": forFriday,
      "Saturday": forSaturday,
      "Sunday": forSunday,
    };

    Map<String, dynamic> data = {
      "Time Based": isTimeBased,
      "Title": habitTitle,
      "isBlind": isBlind,
      "isDeaf": isDeaf,
      "wantNotifcations": wantNotifications,
      "Days": days,
      "UserID": uid,
      "isComplete": false,
      "isCurrent": isCurrent,
      "dailyCompletions": 0,
      "weeklyCompletions": 0,
      "monthlyCompletions": 0,
      "yearlyCompletions": 0,
      "streak": 0
    };

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // Take all of the data from form and save it to the database
      firestore.collection('/habits').add(data);

      isCurrent = false;
      isTimeBased = false;
      isBlind = false;
      isDeaf = false;
      forMonday = false;
      forTuesday = false;
      forWednesday = false;
      forThursday = false;
      forFriday = false;
      forSaturday = false;
      forSunday = false;
      wantNotifications = true;

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    createTimeChoosingTypeDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Would you like to take a Timer or a Stopwatch"),
              content: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.timer), onPressed: null),
                  IconButton(icon: Icon(Icons.watch), onPressed: null)
                ],
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new habit"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "Name of the habit"),
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please enter the habit title' : null,
                  onChanged: (input) => habitTitle = input,
                ),
                CheckboxListTile(
                    title: Text("Primary Habit?"),
                    value: isCurrent,
                    onChanged: (bool value) {
                      setState(() {
                        isCurrent = value;
                      });
                    }, //added this checkbox to have a primary habit change or added.
                    secondary: Icon(Icons.priority_high)),
                CheckboxListTile(
                    title: Text("Time Based"),
                    value: isTimeBased,
                    onChanged: (bool value) {
                      setState(() {
                        //time type
                        //make a bool TimeType, if 0 its a timer, if 1 its a stopwatch
                        //
                        createTimeChoosingTypeDialog(context);
                        isTimeBased = value;
                      });
                    },
                    secondary: Icon(Icons.timer)),
                CheckboxListTile(
                    title: Text("Are you visually disabled?"),
                    value: isBlind,
                    onChanged: (bool value) {
                      setState(() {
                        isBlind = value;
                      });
                    },
                    secondary: Icon(Icons.visibility_off)),
                CheckboxListTile(
                    title: Text("Are you deaf?"),
                    value: isDeaf,
                    onChanged: (bool value) {
                      setState(() {
                        isDeaf = value;
                      });
                    },
                    secondary: Icon(Icons.hearing)),
                CheckboxListTile(
                    title: Text("Do you want notifications?"),
                    value: wantNotifications,
                    onChanged: (bool value) {
                      setState(() {
                        wantNotifications = value;
                      });
                    },
                    secondary: Icon(Icons.notifications)),
                Text("On what days do you plan on doing this habit?"),
                CheckboxListTile(
                    title: Text("Monday"),
                    value: forMonday,
                    onChanged: (bool value) {
                      setState(() {
                        forMonday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Tuesday"),
                    value: forTuesday,
                    onChanged: (bool value) {
                      setState(() {
                        forTuesday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Wednesday"),
                    value: forWednesday,
                    onChanged: (bool value) {
                      setState(() {
                        forWednesday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Thursday"),
                    value: forThursday,
                    onChanged: (bool value) {
                      setState(() {
                        forThursday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Friday"),
                    value: forFriday,
                    onChanged: (bool value) {
                      setState(() {
                        forFriday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Saturday"),
                    value: forSaturday,
                    onChanged: (bool value) {
                      setState(() {
                        forSaturday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Sunday"),
                    value: forSunday,
                    onChanged: (bool value) {
                      setState(() {
                        forSunday = value;
                      });
                    }),
                RaisedButton(onPressed: createHabit, child: Text("Add"))
              ],
            ),
          ),
        ));
  }
}
