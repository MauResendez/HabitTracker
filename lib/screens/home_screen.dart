import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:numberpicker/numberpicker.dart';

class HomeScreen extends StatefulWidget 
{
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// final FirebaseAuth auth = FirebaseAuth.instance;

// final User user = auth.currentUser;
// final uid = user.uid;

class _HomeScreenState extends State<HomeScreen> 
{
  FirebaseAuth auth = FirebaseAuth.instance;
  User user; 
  var uid;

  //start of the timer variables
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timedisplay = "";
  bool checktimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    print(timeForTimer.toString());

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checktimer == false) {
          t.cancel();
          checktimer = true;
          timedisplay = "";
          started = true;
          stopped = true;
        } //value is less then 1 min.
        else if (timeForTimer < 60) {
          timedisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        }
        //value is less then 1 hour.
        else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timedisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          //value is greater then one hour.
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timedisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

  Widget timer() 
  {
    return Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            Column(
              children: <Widget>
              [
                Padding
                (
                  padding: EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  child: Text("HH"),
                ),
                NumberPicker.integer
                (
                  initialValue: hour,
                  minValue: 0,
                  maxValue: 23,
                  listViewWidth: 60.0,
                  onChanged: (val) 
                  {
                    setState(() 
                    {
                      hour = val;
                    });
                  },
                )
              ],
            ),
            //this is the minutes for the timer
            Column
            (
              children: <Widget>
              [
                Padding
                (
                  padding: EdgeInsets.only
                  (
                    bottom: 5.0,
                  ),
                  child: Text("MIN"),
                ),
                NumberPicker.integer
                (
                  initialValue: min,
                  minValue: 0,
                  maxValue: 23,
                  listViewWidth: 60.0,
                  onChanged: (val) 
                  {
                    setState(() 
                    {
                      min = val;
                    });
                  },
                )
              ],
            ),
            //this is the seconds for the timer
            Column
            (
              children: <Widget>
              [
                Padding
                (
                  padding: EdgeInsets.only
                  (
                    bottom: 5.0,
                  ),
                  child: Text("SEC"),
                ),
                NumberPicker.integer
                (
                  initialValue: sec,
                  minValue: 0,
                  maxValue: 23,
                  listViewWidth: 60.0,
                  onChanged: (val) 
                  {
                    setState(() 
                    {
                      sec = val;
                    });
                  },
                )
              ],
            ),
          ],
        ),
        Text(timedisplay),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>
          [
            ElevatedButton
            (
              onPressed: started ? start : null,
              child: Text("Start"),
            ),
            ElevatedButton
            (
              onPressed: stopped ? null : stop,
              child: Text("Stop"),
            )
          ],
        )
      ],
    );
  }

  //start of the stopwatch variables
  bool startpressed = true;
  bool stoppressed = true;
  bool resetpressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer() 
  {
    Timer(dur, keeprunning);
  }

  void keeprunning() 
  {
    if (swatch.isRunning) 
    {
      starttimer();
    }

    setState(() 
    {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() 
  {
    setState(() {
      stoppressed = false;
      startpressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() 
  {
    setState(() {
      //save date started the stopwatch
      stoppressed = true;
      resetpressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch() 
  {
    setState(() 
    {
      //save into the database

      startpressed = true;
      resetpressed = true;
    });
    //save the total before deleting info and send to database;

    stoptimetodisplay = "00:00:00";
    swatch.reset();
  }

  Widget stopwatch() 
  {
    return Container
    (
      child: Column
      (
        children: <Widget>
        [
          Container
          (
            alignment: Alignment.center,
            child: Text
            (
              stoptimetodisplay,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(),
          Container
          (
            child: Column
            (
              children: <Widget>
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>
                  [
                    ElevatedButton
                    (
                      onPressed: stoppressed ? null : stopstopwatch,
                      child: Text("STOP"),
                    ),
                    ElevatedButton
                    (
                      onPressed: resetpressed ? null : resetstopwatch,
                      child: Text("RESET"),
                    )
                  ],
                ),
                SizedBox(),
                ElevatedButton
                (
                  onPressed: startpressed ? startstopwatch : null,
                  child: Text("START"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void getUser()
  {
    setState(() 
    {
      user = auth.currentUser;
      uid = user.uid;
    });
  }

  void initState()
  {
    getUser();
    super.initState();
  }

 Widget getHabitTypeWidget(String type) 
 { 
    switch (type) 
    {
      case "Timer":
        //display the widget timer in the home page withits habit type.
        return Column
        (
          children: [timer()],
        );
        break;
      case "Stopwatch":
        //return case for the stopwatch using the widget stopwatch created in the home page
        return Column
        (
          children: [stopwatch()],
        );
        break;
      default:
        return TextButton(onPressed: null, child: const Text("Hello There"));
        break;
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    //pop up dialog when completing the task
    CreateCongratulationDialog(BuildContext context) 
    {
      return showDialog
      (
          context: context,
          builder: (context) 
          {
            return AlertDialog
            (
              title: Text("Congratulations!"),
              content: IconButton(icon: Icon(Icons.share), onPressed: () {}),
              actions: <Widget>
              [
                MaterialButton
                (
                  onPressed: () 
                  {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text("OK"),
                )
              ],
            );
          }
      );
    }

    return Scaffold
    (
      body: Container
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            SizedBox
            (
              height: 20,
            ),
            StreamBuilder
            (
              // stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('isCurrent', isEqualTo: true).snapshots(),
              stream: FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where('inProgress', isEqualTo: true).snapshots(),
              builder: (context, snapshot) 
              {
                if(!snapshot.hasData) 
                {
                  return Center
                  (
                    child: Text('Loading data. Please wait...'),
                  );
                }

                if(snapshot.data.documents.length == 0)
                {
                  return Center
                  (
                    child: Text("No current habit in progress", style: TextStyle(fontSize: 20))
                  );
                }

                return Column
                (
                  children: <Widget> 
                  [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("Current Habit: ${snapshot.data.documents[0]["Title"]}", style: TextStyle(fontSize: 30))]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("Start Time: ${snapshot.data.documents[0]["startTime"]}", style: TextStyle(fontSize: 20))]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("End Time: ${snapshot.data.documents[0]["endTime"]}", style: TextStyle(fontSize: 20))]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("Completions: ${snapshot.data.documents[0]["Completions"]}", style: TextStyle(fontSize: 20))]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("Streak: ${snapshot.data.documents[0]["Streak"]}", style: TextStyle(fontSize: 20))]),
                    getHabitTypeWidget(snapshot.data.documents[0]["Type"])
                  ],
                );
              }
            )
          ],
        ),
      ),
    );


  }
}
