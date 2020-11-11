import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'home_screen.dart';

List<List<CircularStackEntry>> _pieData = [
  <CircularStackEntry>[
    CircularStackEntry(<CircularSegmentEntry>[
      CircularSegmentEntry(50.0, Colors.green, rankKey: 'D1'),
      CircularSegmentEntry(20.0, Colors.blue, rankKey: 'D2'),
      CircularSegmentEntry(25.0, Colors.yellow, rankKey: 'D3'),
    ])
  ],
];

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _size = Size(200.0, 200.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedCircularChart(
        size: _size,
        initialChartData: _pieData[0],
      ),
    );
  }
}
