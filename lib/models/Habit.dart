import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Habit 
{
  final String id;
  final String title;
  final bool isHandicapped;
  final bool isTime;
  final Color cardColor;
  // time
  // days of the week
  // button color
  // button noise

  Habit
  ({
    this.id,
    this.title,
    this.isHandicapped,
    this.isTime,
    this.cardColor
  });
}