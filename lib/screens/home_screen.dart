import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

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
    switch(type)
    {
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
