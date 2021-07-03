import 'package:flutter/material.dart';
import 'home_screen.dart';

int activehabits = 0;
int completionhabithistory = 0;
/*
List<List<CircularStackEntry>> _pieData = [
  <CircularStackEntry>[
    CircularStackEntry(<CircularSegmentEntry>[
      CircularSegmentEntry(50.0, Colors.green, rankKey: 'D1'),
      CircularSegmentEntry(20.0, Colors.blue, rankKey: 'D2'),
      CircularSegmentEntry(25.0, Colors.yellow, rankKey: 'D3'),
    ])
  ],
];*/

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _size = Size(200.0, 200.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Sun."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Mon."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Tues."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Wed."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Thurs."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Fri."),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: null,
                  child: Text("Sat."),
                ),
              )
            ],
          ),
          Expanded(
              child: Row(
            children: <Widget>[
              /* AnimatedCircularChart(
                size: _size,
                initialChartData: _pieData[0],
              ),*/
              Column(
                children: <Widget>[
                  Text("Completion: " + completionhabithistory.toString()),
                  Text("Active Habits: " + activehabits.toString())
                ],
              )
            ],
          )),
          Expanded(child: Text("Habit List for Today"))
        ],
      ),
    );
  }
}
