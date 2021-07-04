import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/login_screen.dart';
import 'package:habittracker/screens/register_screen.dart';
import 'package:habittracker/screens/tab_screen.dart';
import 'package:habittracker/screens/home_screen.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  Widget getScreenId() 
  {
    return StreamBuilder<User>
    (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) 
        {
          if (snapshot.hasData) 
          {
            return TabScreen();
          } 
          else 
          {
            return LoginScreen();
          }
        });
  }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
        title: 'Habit Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData
        (
          primarySwatch: Colors.blue,
        ),
        home: getScreenId(),
        routes: 
        {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        }
    );
  }
}
