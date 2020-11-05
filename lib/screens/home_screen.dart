import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

import 'create_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/*List<Map<String, int>> database = [
    {"taskT": "Understand Code", "taskS": 12,"habitmade": "10:15 2/15/2020"},
    {"taskT": "Figure out duplication", "taskS": 12,"habitmade": "10:15 2/15/2020"},
    {"taskT": "Refactor", "taskS": 12,"habitmade": "10:15 2/15/2020"},
    {"taskT": "Add comments", "taskS": 12,"habitmade": "10:15 2/15/2020"},
    {"taskT": "commit code", "taskS": 12,"habitmade": "10:15 2/15/2020"},
    {"taskT": "push to github", "taskS": 12, "habitmade": "10:15 2/15/2020"}
  ];*/

List database = [
  {"Understand Code", 12, "10:15 2/15/2020"},
  {"Understand Code", 12, "10:15 2/15/2020"},
  {"Understand Code", 12, "10:15 2/15/2020"}
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
        children: <Widget>[
          Center(
              child: FlatButton(
                  onPressed: () => AuthService.logout(),
                  child: Text("Log Out"))),
          /*ListView.builder(
              itemCount: database.length,
              itemBuilder: (context, i) {
                return MyHabit(database[i][0].toString(), database[i][1],
                    database[i][2].toString());
              }),*/
          //displaying the 3 Cards as demo
          MyHabit("HabitTitle5", 12, "10:15 2/15/2020"),
          MyHabit("HabitTitle6", 12, "10:15 2/20/2020"),
          MyHabit("HabitTitle7", 12, "10:15 2/27/2020")
        ],
      )),
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
  String HabitTitle;
  int HabitTrack;
  String Timecomplete;
  //add any other things leave at 2 for now
  MyHabit(this.HabitTitle, this.HabitTrack, this.Timecomplete);
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
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${widget.HabitTrack}",
                      style: new TextStyle(fontSize: 35.0),
                    ),
                    Spacer(),
                    Icon(Icons.timer),
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
