import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

bool existingHadicapped = true;
bool existingNotifications = true;

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.add),
              hintText: 'Name Your Habit',
              labelText: 'Habit *'),
        ),
        CheckboxListTile(
            title: Text("Handicapped"),
            value: existingHadicapped,
            onChanged: (value) {
              setState(() {
                existingHadicapped = value;
              });
            }),
        CheckboxListTile(
            title: Text("Notifications"),
            value: existingNotifications,
            onChanged: (value) {
              setState(() {
                existingNotifications = value;
              });
            })
      ],
    ));
  }
}
