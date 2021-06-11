import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class EditScreen extends StatefulWidget 
{
  var id;

  EditScreen({Key key, @required this.id}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

void initState() {}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class _EditScreenState extends State<EditScreen> 
{
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

  void initState()
  {
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
    super.initState();
  }

  updateHabit() 
  {
    Map<String, dynamic> days = 
    {
      "Monday": monday,
      "Tuesday": tuesday,
      "Wednesday": wednesday,
      "Thursday": thursday,
      "Friday": friday,
      "Saturday": saturday,
      "Sunday": sunday,
    };

    Map<String, dynamic> data = 
    {
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

    if (formKey.currentState.validate()) 
    {
      formKey.currentState.save();

      // Take all of the data from form and save it to the database
      // firestore.collection('/habits').add(data);

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
    }
  }

  // TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
  // 
  // import 'package:intl/intl.dart';
// parse date
// DateTime date= DateFormat.jm().parse("6:45 PM");
// DateTime date2= DateFormat("hh:mma").parse("6:45PM"); // think this will work better for you
// // format date
// print(DateFormat("HH:mm").format(date));
// print(DateFormat("HH:mm").format(date2));


  onSaveStartTime() async
  {
    if(startTime == null)
    {
      startTime = TimeOfDay.now();
    }

    startTime = await showTimePicker(context: context, initialTime: startTime);
    print(startTime);
  }

  onSaveEndTime() async
  {
    if(endTime == null)
    {
      endTime = TimeOfDay.now();
    }

    endTime = await showTimePicker(context: context, initialTime: endTime);
    print(endTime);
    print(uid);

    // DateFormat('hh:mm aa').format(alarm.alarmDateTime);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
        resizeToAvoidBottomPadding: false,
        appBar: AppBar
        (
          title: Text("Edit your habit"),
        ),
        body: SingleChildScrollView
        (
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form
          (
            key: formKey,
            child: Column
            (
              children: <Widget>
              [
                TextFormField
                (
                  decoration: InputDecoration(hintText: "Name of the habit"),
                  validator: (input) => !input.isNotEmpty ? 'Please enter the habit title' : null,
                  onChanged: (input) => habitTitle = input,
                ),
                RaisedButton(onPressed: onSaveStartTime, child: Text("Start Time")),
                RaisedButton(onPressed: onSaveEndTime, child: Text("End Time")),
                CheckboxListTile
                (
                    title: Text("Primary Habit?"),
                    value: isCurrent,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        isCurrent = value;
                      });
                    }, //added this checkbox to have a primary habit change or added.
                    secondary: Icon(Icons.priority_high)
                ),
                // CheckboxListTile
                // (
                //     title: Text("Time Based"),
                //     value: isTimeBased,
                //     onChanged: (bool value) 
                //     {
                //       setState(() 
                //       {
                //         //time type
                //         //make a bool TimeType, if 0 its a timer, if 1 its a stopwatch
                //         //
                //         createTimeChoosingTypeDialog(context);
                //         isTimeBased = value;
                //       });
                //     },
                //     secondary: Icon(Icons.timer)
                // ),
                // SizedBox(height: 10),
                Text("What type of habit do you want?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                ListTile
                (
                  title: const Text('Default'),
                  leading: Radio
                  (
                    value: "Default",
                    groupValue: habitType,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        habitType = value;
                      });
                    },
                  ),
                ),
                ListTile
                (
                  title: const Text('Timer'),
                  leading: Radio
                  (
                    value: "Timer",
                    groupValue: habitType,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        habitType = value;
                      });
                    },
                  ),
                ),
                ListTile
                (
                  title: const Text('Stopwatch'),
                  leading: Radio
                  (
                    value: "Stopwatch",
                    groupValue: habitType,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        habitType = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("On what days do you plan on doing this habit?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                CheckboxListTile
                (
                    title: Text("Monday"),
                    value: monday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        monday = value;
                      });
                    }
                ),
                CheckboxListTile
                (
                    title: Text("Tuesday"),
                    value: tuesday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        tuesday = value;
                      });
                    }
                ),
                CheckboxListTile
                (
                    title: Text("Wednesday"),
                    value: wednesday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        wednesday = value;
                      });
                    }
                ),
                CheckboxListTile
                (
                    title: Text("Thursday"),
                    value: thursday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        thursday = value;
                      });
                    }
                ),
                CheckboxListTile
                (
                    title: Text("Friday"),
                    value: friday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        friday = value;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Saturday"),
                    value: saturday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        saturday = value;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Sunday"),
                    value: sunday,
                    onChanged: (bool value) 
                    {
                      setState(() 
                      {
                        sunday = value;
                      });
                    }
                ),
                SizedBox(height: 10),
                Text("LED Color?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                ListTile
                (
                  title: const Text('Red'),
                  leading: Radio
                  (
                    value: "Red",
                    groupValue: ledColor,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile
                (
                  title: const Text('Green'),
                  leading: Radio
                  (
                    value: "Green",
                    groupValue: ledColor,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile
                (
                  title: const Text('Yellow'),
                  leading: Radio
                  (
                    value: "Yellow",
                    groupValue: ledColor,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                ListTile
                (
                  title: const Text('Blue'),
                  leading: Radio
                  (
                    value: "Blue",
                    groupValue: ledColor,
                    onChanged: (value) 
                    {
                      setState(() 
                      {
                        ledColor = value;
                      });
                    },
                  ),
                ),
                RaisedButton(onPressed: updateHabit, child: Text("Add"))
              ],
            ),
          ),
        ));
  }
}
