import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class EditScreen extends StatefulWidget 
{
  final String id;

  EditScreen({Key key, @required this.id}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

// final FirebaseAuth auth = FirebaseAuth.instance;
// final User user = auth.currentUser;
// final uid = user.uid;

class _EditScreenState extends State<EditScreen> 
{
  FirebaseAuth auth = FirebaseAuth.instance;
  User user; 
  var uid;
  var hid;

  void getUser()
  {
    setState(() 
    {
      user = auth.currentUser;
      uid = user.uid;
      hid = widget.id;
    });
  }

  void initState()
  {
    getUser();
    initializeHabit();    
    super.initState();
  }

  bool error = false;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool saturday;
  bool sunday;
  String habitType = "Default";
  String habitTitle = "";
  String ledColor = "Red";
  TimeOfDay timeGetter;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime formatStartTime;
  DateTime formatEndTime;

  final firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  initializeHabit() async
  {
    DocumentSnapshot currentHabit = await FirebaseFirestore.instance.collection('habits').doc(hid).get();

    setState(() 
    {
      monday = currentHabit.data()["Days"]["Monday"];
      tuesday = currentHabit.data()["Days"]["Tuesday"];
      wednesday = currentHabit.data()["Days"]["Wednesday"];
      thursday = currentHabit.data()["Days"]["Thursday"];
      friday = currentHabit.data()["Days"]["Friday"];
      saturday = currentHabit.data()["Days"]["Saturday"];
      sunday = currentHabit.data()["Days"]["Sunday"];
      habitType = currentHabit.data()["Type"];
      habitTitle = currentHabit.data()["Title"];
      ledColor = currentHabit.data()["LED Color"];
      formatStartTime = DateFormat.jm().parse(currentHabit.data()["startTime"]);
      formatEndTime = DateFormat.jm().parse(currentHabit.data()["endTime"]);

      startTime = TimeOfDay(hour: int.parse(DateFormat("HH:mm").format(formatStartTime).split(":")[0]), minute: int.parse(DateFormat("HH:mm").format(formatStartTime).split(":")[1]));
      endTime = TimeOfDay(hour: int.parse(DateFormat("HH:mm").format(formatEndTime).split(":")[0]), minute: int.parse(DateFormat("HH:mm").format(formatEndTime).split(":")[1]));

    });
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
      "startTime": startTime.format(context),
      "endTime": endTime.format(context),
    };

    if(formKey.currentState.validate()) 
    {
      formKey.currentState.save();

      // Take all of the data from form and save it to the database

      firestore.collection('/habits').doc(hid).update(data);
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
                  initialValue: habitTitle,
                ),
                RaisedButton(onPressed: onSaveStartTime, child: Text("Start Time")),
                RaisedButton(onPressed: onSaveEndTime, child: Text("End Time")),
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
                RaisedButton(onPressed: updateHabit, child: Text("Edit"))
              ],
            ),
          ),
        ));
  }
}
