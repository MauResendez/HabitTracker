import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:habittracker/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  const HomeScreen({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _HomeScreenState extends State<HomeScreen> {
  final String SERVICE_UUID = "00001523-1212-EFDE-1523-785FEABCD123";
  final String CHARACTERISTIC_UUID = "00001524-1212-EFDE-1523-785FEABCD123";
  bool isReady;
  Stream<List<int>> stream;

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  _Pop() async {
    Navigator.of(context).pop(true);
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }

    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);

            //see if this prints value sent from button only using that uuid as of now.
            //an increament
            //this characteristic is to triger a function. in this case the primary habit on stand by.
            //
            stream = characteristic.value;

            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _Pop();
    }
  }
  // logout()
  // {
  //   AuthService.logout();
  // }

  // Timer timer;
  // QuerySnapshot currentHabit;

  // void startHabit() async
  // {
  //   print("In the start habit function");
  //   currentHabit = await FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('startTime', isEqualTo: TimeOfDay.now().format(context)).get();
  // }

  // void endHabit() async
  // {
  //   print("In the end habit function");
  //   currentHabit = await FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('endTime', isEqualTo: TimeOfDay.now().format(context)).get();
  // }

  // @override
  // void initState()
  // {
  //   timer = Timer.periodic
  //   (
  //     Duration(seconds: 10), (Timer t) =>
  //     setState
  //     (()
  //     {
  //       if(currentHabit == null || currentHabit.docs.isEmpty)
  //       {
  //         print("Null");
  //         startHabit();
  //       }
  //       else
  //       {
  //         print("HI");
  //         print(currentHabit.docs[0]["Title"]);
  //       }
  //     })
  //   );

  //   super.initState();

  //   // Every 15 seconds, we check all of the current habits
  //   // and see if one of them has the same start time as the current time
  //   //
  //   // If one of them is, make that the current habit
  //   // loop
  //   // // if(current_habit["startTime"] == TimeOfDay.now().format(context))
  //   // // {
  //   // //     current_habit["hasStarted"] = true;
  //   // // }
  // }

  // @override
  // void dispose()
  // {
  //   timer?.cancel();
  //   super.dispose();
  // }

  Widget getHabitTypeWidget(String type) {
    switch (type) {
      case "Timer":
        return Text("Timer");
        break;
      case "Stopwatch":
        return Text("Stopwatch");
        break;
      default:
        return Text("");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //pop up dialog when completing the task
    CreateCongratulationDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Congratulations!"),
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                // stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('isCurrent', isEqualTo: true).snapshots(),
                stream: FirebaseFirestore.instance
                    .collection('habits')
                    .where('UserID', isEqualTo: uid)
                    .where('inProgress', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Loading data. Please wait...'),
                    );
                  }

                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Text("No current habit in progress",
                          style: TextStyle(fontSize: 20)),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Current Habit: ${snapshot.data.documents[0]["Title"]}",
                                style: TextStyle(fontSize: 30))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Start Time: ${snapshot.data.documents[0]["startTime"]}",
                                style: TextStyle(fontSize: 20))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "End Time: ${snapshot.data.documents[0]["endTime"]}",
                                style: TextStyle(fontSize: 20))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Completions: ${snapshot.data.documents[0]["Completions"]}",
                                style: TextStyle(fontSize: 20))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Streak: ${snapshot.data.documents[0]["Streak"]}",
                                style: TextStyle(fontSize: 20))
                          ]),
                      getHabitTypeWidget(snapshot.data.documents[0]["Type"])
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
