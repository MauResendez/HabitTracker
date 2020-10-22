import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';

class HomeScreen extends StatefulWidget 
{
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: FlatButton
        (
          onPressed: () => AuthService.logout(),
          child: Text("Log Out")
        )
      ) 
    );
  }
}