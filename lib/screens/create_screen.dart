import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

// final FirebaseAuth auth = FirebaseAuth.instance;
// final User user = auth.currentUser;
// final uid = user.uid;

class _CreateScreenState extends State<CreateScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  var uid;

  void getUser() {
    setState(() {
      user = auth.currentUser;
      uid = user.uid;
    });
  }

  void initState() {
    getUser();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
    super.initState();
  }

  bool isCurrent = false; //abrahan had added to see if works when save habit
  bool error = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  String habitType = "Default";
  String habitTitle = "";
  String ledColor = "Red";
  TimeOfDay timeGetter;
  TimeOfDay startTime;
  TimeOfDay endTime;

  final firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  createHabit() {
    Map<String, dynamic> days = {
      "Monday": monday,
      "Tuesday": tuesday,
      "Wednesday": wednesday,
      "Thursday": thursday,
      "Friday": friday,
      "Saturday": saturday,
      "Sunday": sunday,
    };

    Map<String, dynamic> data = {
      "Type": habitType,
      "LED Color": ledColor,
      "Title": habitTitle,
      "Days": days,
      "UserID": uid,
      "isCurrent": isCurrent,
      "inProgress": false,
      "startTime": startTime.format(context),
      "endTime": endTime.format(context),
      "Completions": 0,
      "Attempts": 0,
      "Streak": 0
    };

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (habitTitle.isNotEmpty &&
          (monday ||
              tuesday ||
              wednesday ||
              thursday ||
              friday ||
              saturday ||
              sunday)) {
        // Take all of the data from form and save it to the database
        firestore.collection('/habits').add(data);

        isCurrent = false;
        habitType = "Default";
        monday = false;
        tuesday = false;
        wednesday = false;
        thursday = false;
        friday = false;
        saturday = false;
        sunday = false;

        Navigator.pop(context);
      } else {
        setState(() {
          error = true;
        });
      }
    }
  }

  checkTimeAndDays() {}

  onSaveStartTime() async {
    if (startTime == null) {
      startTime = TimeOfDay.now();
    }

    timeGetter = await showTimePicker(context: context, initialTime: startTime);

    if (timeGetter !=
        null) // If cancel button isn't pressed or isn't pressed outside of timepicker, set the start time
    {
      startTime = timeGetter;
    }

    print(startTime);
  }

  onSaveEndTime() async {
    if (endTime == null) {
      endTime = TimeOfDay.now();
    }

    timeGetter = await showTimePicker(context: context, initialTime: endTime);

    if (timeGetter !=
        null) // If cancel button isn't pressed or isn't pressed outside of timepicker, set the start time
    {
      endTime = timeGetter;
    }
  }

  Widget errorMessage(bool err) {
    if (err == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("One or more fields are incomplete",
            style: TextStyle(fontSize: 17, color: Colors.red)),
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          onPressed: onSaveStartTime,
                          child: Text("Start Time")),
                      RaisedButton(
                          onPressed: onSaveEndTime, child: Text("End Time")),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Text("What type of habit do you want?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                ListTile(
                  title: const Text('Default'),
                  leading: Radio(
                    value: "Default",
                    groupValue: habitType,
                    onChanged: (value) {
                      setState(() {
                        habitType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Timer'),
                  leading: Radio(
                    value: "Timer",
                    groupValue: habitType,
                    onChanged: (value) {
                      setState(() {
                        habitType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Stopwatch'),
                  leading: Radio(
                    value: "Stopwatch",
                    groupValue: habitType,
                    onChanged: (value) {
                      setState(() {
                        habitType = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("On what days do you plan on doing this habit?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                CheckboxListTile(
                    title: Text("Monday"),
                    value: monday,
                    onChanged: (bool value) {
                      setState(() {
                        monday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Tuesday"),
                    value: tuesday,
                    onChanged: (bool value) {
                      setState(() {
                        tuesday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Wednesday"),
                    value: wednesday,
                    onChanged: (bool value) {
                      setState(() {
                        wednesday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Thursday"),
                    value: thursday,
                    onChanged: (bool value) {
                      setState(() {
                        thursday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Friday"),
                    value: friday,
                    onChanged: (bool value) {
                      setState(() {
                        friday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Saturday"),
                    value: saturday,
                    onChanged: (bool value) {
                      setState(() {
                        saturday = value;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Sunday"),
                    value: sunday,
                    onChanged: (bool value) {
                      setState(() {
                        sunday = value;
                      });
                    }),
                SizedBox(height: 10),
                Text("LED Color?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                ListTile(
                  title: const Text('Red'),
                  leading: Radio(
                    value: "Red",
                    groupValue: ledColor,
                    onChanged: (value) {
                      setState(() {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Green'),
                  leading: Radio(
                    value: "Green",
                    groupValue: ledColor,
                    onChanged: (value) {
                      setState(() {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Yellow'),
                  leading: Radio(
                    value: "Yellow",
                    groupValue: ledColor,
                    onChanged: (value) {
                      setState(() {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Blue'),
                  leading: Radio(
                    value: "Blue",
                    groupValue: ledColor,
                    onChanged: (value) {
                      setState(() {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                errorMessage(error),
                RaisedButton(onPressed: createHabit, child: Text("Add")),
              ],
            ),
          ),
        ));
  }
}
