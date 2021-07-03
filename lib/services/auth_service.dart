import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService 
{
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static void registerUser(BuildContext context, String first_name, String last_name, String email, String password) async 
  {
    try 
    {
      User user = (await auth.createUserWithEmailAndPassword(email: email, password: password)).user; // create a new user

      if (user != null) // If user has been created, document (save) data from the user into firestore
      {
        firestore.collection('/users').doc(user.uid).set({'firstName': first_name, 'lastName': last_name, 'email': email, 'profileImageURL': ''});
      }

      setUID();

      // Navigator.pushReplacementNamed(context, FeedScreen.id);
      Navigator.pop(context);
    } 
    catch (e) 
    {
      print(e);
    }
  }

  static void logout() async
  {
    await auth.signOut();
    // Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void login(String email, String password) async 
  {
    try 
    {
      await auth.signInWithEmailAndPassword(email: email, password: password); // signs in user

      setUID();

      // .then(()
      // {
      //   setUID();
      // });

      // Navigator.pushReplacementNamed(context, FeedScreen.id);
    } 
    catch (e) 
    {
      print(e);
    }
  }

  static void setUID() async
  {
    var res = await http.post(Uri.http(auth.currentUser.uid.toString(), '/uid'),
    body: 
    {
      "UID": auth.currentUser.uid.toString(),
    });
  }
}
