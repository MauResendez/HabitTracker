import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:habittracker/screens/feed_screen.dart';
import 'package:habittracker/screens/login_screen.dart';

class AuthService
{
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static Future<void> registerUser(BuildContext context, String username, String email, String password) async 
  {
    try
    {
      User user = (await auth.createUserWithEmailAndPassword(email: email, password: password)).user; // create a new user

      if(user != null) // If user has been created, document (save) data from the user into firestore
      {
        firestore.collection('/users').doc(user.uid).set
        ({
          'username': username,
          'email': email,
          'profileImageUrl': ''
        });
      }

      // Navigator.pushReplacementNamed(context, FeedScreen.id);
      Navigator.pop(context);
    }
    catch(e)
    {
      print(e);
    }
  }

  static void logout()
  {
    auth.signOut();
    // Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static Future<void> login(String email, String password) async 
  {
    try
    {
      await auth.signInWithEmailAndPassword(email: email, password: password); // signs in user
      // Navigator.pushReplacementNamed(context, FeedScreen.id);
    }
    catch(e)
    {
      print(e);
    }
  }
}