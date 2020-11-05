import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

bool isHandicapped = true;

class _CreateScreenState extends State<CreateScreen> {
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
              value: isHandicapped,
              onChanged: (value) {
                setState(() {
                  isHandicapped = value;
                });
              }),
          CheckboxListTile(
              title: Text("Notifications"),
              value: isHandicapped,
              onChanged: (value) {}),
          /*TextFormField(
            decoration: InputDecoration(labelText: 'title'),
            validator: (input) => !input.contains('@') || !input.isNotEmpty
                ? 'Please enter Habit Name'
                : null,
            onSaved: (input) => /*title*/ = input,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (input) =>
                !input.isNotEmpty ? 'Please enter a valid password' : null,
            onSaved: (input) => /*password*/ = input,
            obscureText: true,
          ),*/
        ],
      ),
    );
  }
}
