import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/login_screen.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:string_validator/string_validator.dart';

class RegisterScreen extends StatefulWidget 
{
  static final String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> 
{
  final formKey = GlobalKey<FormState>();
  String first_name, last_name, email, password;
  TapGestureRecognizer recognizer;

  submit() 
  {
    if(formKey.currentState.validate()) 
    {
      formKey.currentState.save();
      AuthService.registerUser(context, first_name, last_name, email, password);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: SingleChildScrollView
      (
        child: Container
        (
          height: MediaQuery.of(context).size.height, // Height of the entire screen
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              Text("Habit Tracker", style: TextStyle(color: Colors.blue, fontSize: 60, fontFamily: 'Lobster')),
              Form
              (
                key: formKey,
                child: Padding
                (
                  padding: const EdgeInsets.all(50.0),
                  child: Column
                  (
                    mainAxisSize: MainAxisSize.min,
                    children: 
                    [
                      TextFormField
                      (
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator: (input) => !isAlphanumeric(input) || !input.isNotEmpty ? 'Please enter your first name' : null,
                        onChanged: (input) => first_name = input.trim(),
                      ),
                      TextFormField
                      (
                        decoration: InputDecoration(labelText: 'Last Name'),
                        validator: (input) => !isAlphanumeric(input) || !input.isNotEmpty ? 'Please enter your last name' : null,
                        onChanged: (input) => last_name = input.trim(),
                      ),
                      TextFormField
                      (
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !isEmail(input) || !input.isNotEmpty ? 'Please enter a valid email' : null,
                        onChanged: (input) => email = input,
                      ),
                      TextFormField
                      (
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => input.length < 8 || !input.isNotEmpty ? 'Please enter a valid password' : null,
                        onChanged: (input) => password = input,
                        obscureText: true,
                      ),
                      SizedBox(height: 15.0),
                      FlatButton
                      (
                          onPressed: submit,
                          color: Colors.blue,
                          child: Text
                          (
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                      ),
                      Padding
                      (
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
