import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Habit {
  final String user_id;
  String user_title;
  bool user_isHandicapped;
  bool user_isTime;
  Color user_cardColor;
  final List user_habitNotif;
  // time
  // days of the week
  // button color
  // button noise
  Habit(
      {this.user_id,
      this.user_title,
      this.user_isHandicapped,
      this.user_isTime,
      this.user_cardColor,
      this.user_habitNotif});

  String get id => user_id;

  String get title => user_title;

  bool get isHandicapped => user_isHandicapped;

  bool get isTime => user_isTime;

  Color get cardColor => user_cardColor;

  List get habitNotif => user_habitNotif;

  //allow to edit title
  set title(String newTitle) {
    if (newTitle.length <= 50) {
      this.user_title = newTitle;
    }
  }

  //allow to edit handicapped
  set isHandicapped(bool Handicapped) {
    this.user_isHandicapped = Handicapped;
  }

  //allow to edit isTimes
  set isTime(bool Time) {
    this.user_isTime = Time;
  }

  //allow to edit the Color of the card
  set cardColor(Color newColor) {
    this.user_cardColor = newColor;
  }

  //to add a new notification into our class.
  set habitNotif(var newNotif) {}
}
