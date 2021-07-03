import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/calendar_screen.dart';
import 'package:habittracker/screens/home_screen.dart';
import 'package:habittracker/screens/list_screen.dart';
import 'package:habittracker/screens/profile_screen.dart';
import 'package:habittracker/screens/summary_screen.dart';
import 'package:habittracker/services/auth_service.dart';
import 'package:intl/intl.dart';

class TabScreen extends StatefulWidget 
{
  @override
  _TabScreenState createState() => _TabScreenState();
}

// final FirebaseAuth auth = FirebaseAuth.instance;

// final User user = auth.currentUser;
// final uid = user.uid;

class _TabScreenState extends State<TabScreen> 
{
  FirebaseAuth auth = FirebaseAuth.instance;
  User user; 
  var uid;

  void getUser()
  {
    setState(() 
    {
      user = auth.currentUser;
      uid = user.uid;
    });
  }

  @override
  void initState()
  {
    getUser();
    timer = Timer.periodic
    (
      Duration(seconds: 10), (Timer t) =>  
      setState
      (()
      {
        if(currentHabit == null || currentHabit.docs.isEmpty)
        {
          startHabit();
        }
        else
        {
          endHabit();
        }
      })
    );
 
    pageController = PageController();
    super.initState();
  }

  int tabIndex = 0;
  PageController pageController;

  logout() 
  {
    AuthService.logout();
  }

  Timer timer;
  QuerySnapshot currentHabit;
  String currentHabitID;

  void startHabit() async
  {
    currentHabit = await FirebaseFirestore.instance.collection('habits').where('UserID', isEqualTo: uid).where("Days.${DateFormat('EEEE').format(DateTime.now())}", isEqualTo: true).where('startTime', isEqualTo: TimeOfDay.now().format(context)).get();

    // If not null, Say that it's now in progress.
    if(currentHabit != null)
    {
      currentHabitID = currentHabit.docs[0].id;
      FirebaseFirestore.instance.collection("habits").doc(currentHabitID).update({"Attempts": currentHabit.docs[0]["Attempts"] + 1, "inProgress": true});
    }
  }

  void endHabit() async
  {  
    if(currentHabit.docs[0]["endTime"] == TimeOfDay.now().format(context))
    {
      currentHabitID = currentHabit.docs[0].id;
      currentHabit = null;
      FirebaseFirestore.instance.collection("habits").doc(currentHabitID).update({"inProgress": false});
    }
  }

  @override
  void dispose() 
  {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
          backgroundColor: Colors.blue,
          title: Text("Habit Tracker"),
          actions: <Widget>
          [
            IconButton
            (
              icon: Icon
              (
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () 
              {
                logout();
              },
            )
          ],
      ),
      body: PageView
      (
          controller: pageController,
          children: 
          [
            HomeScreen(),
            ListScreen(),
            SummaryScreen(),
            CalendarScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (int index) 
          {
            setState(() 
            {
              tabIndex = index;
            });
          }
      ),
      bottomNavigationBar: CupertinoTabBar
      (
          key: Key('BNB'),
          currentIndex: tabIndex,
          onTap: (int index) 
          {
            setState(() 
            {
              tabIndex = index;
            });

            pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
          activeColor: Colors.blue,
          items: 
          [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 32.0), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline, size: 32.0), title: Text('List')),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart, size: 32.0), title: Text('Summary')),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today, size: 32.0), title: Text('Calendar')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 32.0), title: Text('Profile')),
          ]
      ),
    );
  }
}
