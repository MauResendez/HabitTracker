import 'package:flutter/material.dart';
import 'package:habittracker/screens/register_screen.dart';
import 'package:habittracker/services/auth_service.dart';

class LoginScreen extends StatefulWidget 
{
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{
  final formKey = GlobalKey<FormState>();
  String email, password;

  submit() 
  {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      AuthService.login(email, password);
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
              Text("Habit Tracker", style: TextStyle(color: Colors.red, fontSize: 60, fontFamily: 'Lobster')),
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
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !input.contains('@') || !input.isNotEmpty ? 'Please enter a valid email' : null,
                        onChanged: (input) => email = input,
                      ),
                      TextFormField
                      (
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => !input.isNotEmpty ? 'Please enter a valid password' : null,
                        onChanged: (input) => password = input,
                        obscureText: true,
                      ),
                      SizedBox(height: 15.0),
                      FlatButton
                      (
                          onPressed: submit,
                          color: Colors.red,
                          child: Text
                          (
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector
                        (
                            onTap: () => Navigator.pushNamed(context, RegisterScreen.id),
                            child: Text("Don't have an account, register here")),
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
