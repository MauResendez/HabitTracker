import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/login_screen.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:string_validator/string_validator.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String username, email, password;
  TapGestureRecognizer recognizer;

  submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      AuthService.registerUser(context, username, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height, // Height of the entire screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Habit Tracker",
                  style: TextStyle(fontSize: 60, fontFamily: 'Lobster')),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (input) =>
                            !isAlphanumeric(input) || !input.isNotEmpty
                                ? 'Please enter a valid username'
                                : null,
                        onSaved: (input) => username = input.trim(),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) =>
                            !isEmail(input) || !input.isNotEmpty
                                ? 'Please enter a valid email'
                                : null,
                        onSaved: (input) => email = input,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) =>
                            input.length < 8 || !input.isNotEmpty
                                ? 'Please enter a valid password'
                                : null,
                        onSaved: (input) => password = input,
                        obscureText: true,
                      ),
                      SizedBox(height: 15.0),
                      FlatButton(
                          onPressed: submit,
                          color: Colors.red,
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text("Already signed up, log in here")),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
