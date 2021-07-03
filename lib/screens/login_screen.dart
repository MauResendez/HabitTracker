import 'package:flutter/material.dart';
import 'package:habittracker/screens/register_screen.dart';
import 'package:habittracker/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email, password;

  submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      AuthService.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height, // Height of the entire screen
          child:
              Column // Uses a column widget that line up the children widgets vertically
                  (
            mainAxisAlignment: MainAxisAlignment
                .center, // Makes the column centered vertically
            crossAxisAlignment: CrossAxisAlignment
                .center, // Makes the column centered horizontally
            children: [
              Text("Habit Tracker",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 60,
                      fontFamily: 'Lobster')), //
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) =>
                            !input.contains('@') && !input.isNotEmpty
                                ? 'Please enter a valid email'
                                : null,
                        onChanged: (input) => email = input,
                        key: Key('user-textfield'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => !input.isNotEmpty
                            ? 'Please enter a valid password'
                            : null,
                        onChanged: (input) => password = input,
                        obscureText: true,
                        key: Key('pwrd-textfield'),
                      ),
                      SizedBox(height: 15.0),
                      TextButton(
                          onPressed: submit,
                          key: Key('login-button'),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, RegisterScreen.id),
                            child: Text(
                              "Don't have an account, register here",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            )),
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
