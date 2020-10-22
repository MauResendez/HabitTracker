import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      children: <Widget>[
        Center(
            child: FlatButton(
                onPressed: () => AuthService.logout(), child: Text("Log Out"))),
        MyHabit("HabitTitle", 12),
        MyHabit("HabitTitle2", 12),
        MyHabit("HabitTitle3", 12),
        MyHabit("HabitTitle4", 12),
        MyHabit("HabitTitle5", 12),
        MyHabit("HabitTitle6", 12),
        MyHabit("HabitTitle7", 12)
      ],
    )));
  }
}

//this class makes a a show the two variables taken
class MyHabit extends StatefulWidget {
  //variables show to the User when in the homepage,
  String HabitTitle;
  int HabitTrack;
  //add any other things leave at 2 for now
  MyHabit(this.HabitTitle, this.HabitTrack);
  @override
  _MyHabitState createState() => _MyHabitState();
}

class _MyHabitState extends State<MyHabit> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.album,
                    size: 25,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.HabitTrack += 1;
                    });
                  }),
              Expanded(
                  child: Text(
                widget.HabitTitle,
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                widget.HabitTrack.toString(),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ))
            ],
          )
        ],
      ),
    );
  }
}
