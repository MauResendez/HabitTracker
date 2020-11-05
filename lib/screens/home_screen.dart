import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

import 'create_screen.dart';
import 'edit_screen.dart';

int total_habits = 5;

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Map<String, dynamic>> database = [
  {
    "id": 0,
    "taskT": "Understand Code",
    "taskS": 0,
    "habitmade": "10:15 2/15/2020"
  },
  {
    "id": 1,
    "taskT": "Figure out duplication",
    "taskS": 0,
    "habitmade": "10:15 2/15/2020"
  },
  {"id": 2, "taskT": "Refactor", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 3,
    "taskT": "Add comments",
    "taskS": 0,
    "habitmade": "10:15 2/15/2020"
  },
  {"id": 4, "taskT": "commit code", "taskS": 0, "habitmade": "10:15 2/15/2020"},
  {
    "id": 5,
    "taskT": "push to github",
    "taskS": 0,
    "habitmade": "10:15 2/15/2020"
  }
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: database.length,
        itemBuilder: (context, index) {
          return MyHabit((database[index]["id"]), (database[index]["taskT"]),
              (database[index]["taskS"]), (database[index]["habitmade"]));
        },
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
  int id;
  String HabitTitle;
  int HabitTrack;
  String Timecomplete;
  //add any other things leave at 2 for now
  MyHabit(this.id, this.HabitTitle, this.HabitTrack, this.Timecomplete);
  @override
  _MyHabitState createState() => _MyHabitState();
}

// to display the habit info, title, time completed, amount of times completed.
//add a edit button for the habit
class _MyHabitState extends State<MyHabit> {
  int total;
  int habits_total;
  get id => total;

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
                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            widget.HabitTrack += 1;
                            print(widget.HabitTrack);
                          });
                        }),
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
