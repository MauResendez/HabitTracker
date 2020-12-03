import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/screens/calendar_screen.dart';
import 'package:habittracker/screens/habits_screen.dart';
import 'package:habittracker/screens/home_screen.dart';
import 'package:habittracker/screens/list_screen.dart';
import 'package:habittracker/screens/notifications_screen.dart';
import 'package:habittracker/screens/profile_screen.dart';
import 'package:habittracker/screens/summary_screen.dart';

class MainScreen extends StatefulWidget 
{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> 
{
  int tabIndex = 0;
  PageController pageController;

  void initState() 
  {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
          backgroundColor: Colors.blue,
          title: Text
          ("Habit Tracker",
              style: TextStyle
              (
                  color: Colors.white, fontFamily: 'Lobster', fontSize: 35.0
              )
          )
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
          }),
      bottomNavigationBar: CupertinoTabBar
      (
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
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 32.0)),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline, size: 32.0)),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart, size: 32.0)),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today, size: 32.0)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 32.0)),
          ]),
    );
  }
}
