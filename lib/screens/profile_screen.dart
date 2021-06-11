import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/services/auth_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './Quote.dart';
import 'package:numberpicker/numberpicker.dart';

class QuoteData extends StatefulWidget 
{
  @override
  _QuoteDataState createState() => _QuoteDataState();
}

// call the API and fetch the response
Future<Quote> fetchQuote() async 
{
  final response = await http.get('https://favqs.com/api/qotd');
  if (response.statusCode == 200) 
  {
    return Quote.fromJson(json.decode(response.body));
  } 
  else 
  {
    throw Exception('Failed to load Quote');
  }
}

class _QuoteDataState extends State<QuoteData> with AutomaticKeepAliveClientMixin 
{
  @override
  bool get wantKeepAlive => true;

  Future<Quote> quote;
  var dbHelper;
  Future<List<Quote>> wholeQuotes;
  @override
  void initState() 
  {
    super.initState();
    quote = fetchQuote();
  }
}

//ProfileScreen start
class ProfileScreen extends StatefulWidget 
{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser;
final uid = user.uid;

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin 
{
  logout() 
  {
    AuthService.logout();
  }

  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;

  void start() 
  {
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    print(timeForTimer.toString());
  }

  void stop() {}

  @override
  Widget build(BuildContext context) 
  {
    print(uid);
    return Scaffold
    (
      body: StreamBuilder
      (
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) 
        {
          if (!snapshot.hasData) 
          {
            return Center
            (
              child: Text('Loading data. Please wait...'),
            );
          }
          return SingleChildScrollView
          (
              child: Column
              (
              // children: <Widget>
              // [
              //   Text(snapshot.data['email']),
              //   Text(snapshot.data['username']),
              // ],

              children: <Widget>
              [
                Container
                (
                    decoration: BoxDecoration
                    (
                        gradient: LinearGradient
                        (
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue, Colors.green[50]]
                        )
                    ),
                    child: Container
                    (
                      width: double.infinity,
                      height: 205.0,
                      child: Center
                      (
                        child: Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>
                          [
                            CircleAvatar
                            (
                              backgroundImage: NetworkImage(
                                "https://avatarfiles.alphacoders.com/142/142168.jpg",
                              ),
                              radius: 30.0,
                            ),
                            SizedBox
                            (
                              height: 5.0,
                            ),
                            Text
                            (
                              snapshot.data['firstName'] + snapshot.data['lastName'],
                              style: TextStyle
                              (
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox
                            (
                              height: 5.0,
                            ),
                            Card
                            (
                              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding
                              (
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                                child: Row
                                (
                                  children: <Widget>
                                  [
                                    Expanded(
                                      child: Column
                                      (
                                        children: <Widget>
                                        [
                                          Text(
                                            "Complete",
                                            style: TextStyle
                                            (
                                              color: Colors.blue,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox
                                          (
                                            height: 5.0,
                                          ),
                                          Text
                                          (
                                            "42",
                                            style: TextStyle
                                            (
                                              fontSize: 20.0,
                                              color: Colors.blue[10],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded
                                    (
                                      child: Column
                                      (
                                        children: <Widget>
                                        [
                                          Text
                                          (
                                            "Days",
                                            style: TextStyle
                                            (
                                              color: Colors.blue,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox
                                          (
                                            height: 5.0,
                                          ),
                                          Text
                                          (
                                            "142",
                                            style: TextStyle
                                            (
                                              fontSize: 20.0,
                                              color: Colors.blue[10],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded
                                    (
                                      child: Column
                                      (
                                        children: <Widget>
                                        [
                                          Text
                                          (
                                            "Activities",
                                            style: TextStyle
                                            (
                                              color: Colors.blue,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox
                                          (
                                            height: 5.0,
                                          ),
                                          Text
                                          (
                                            "52",
                                            style: TextStyle
                                            (
                                              fontSize: 20.0,
                                              color: Colors.blue[10],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Container
                (
                  child: Padding
                  (
                    padding: const EdgeInsets.symmetric
                    (
                      vertical: 30.0, horizontal: 16.0),
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          SizedBox
                          (
                            height: 1.0,
                          ),
                        //add daily quotes to help user keep up the good work motivational
                        /*Text(
                          'My Well Being \n'
                          'Excellent!',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'My Activity Level is \n'
                          'Excellent!',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),*/
                        //this is the pop up timer to be interted into the create a habit that is timed into a timer
                        Column
                        (
                          children: <Widget>
                          [
                            Row
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>
                              [
                                Column
                                (
                                  children: <Widget>
                                  [
                                    Padding
                                    (
                                      padding: EdgeInsets.only
                                      (
                                        bottom: 5.0,
                                      ),
                                      child: Text("HH"),
                                    ),
                                    NumberPicker.integer
                                    (
                                      initialValue: hour,
                                      minValue: 0,
                                      maxValue: 23,
                                      listViewWidth: 60.0,
                                      onChanged: (val) 
                                      {
                                        setState(() 
                                        {
                                          hour = val;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                //this is the minutes for the timer
                                Column
                                (
                                  children: <Widget>
                                  [
                                    Padding
                                    (
                                      padding: EdgeInsets.only
                                      (
                                        bottom: 5.0,
                                      ),
                                      child: Text("MIN"),
                                    ),
                                    NumberPicker.integer
                                    (
                                      initialValue: min,
                                      minValue: 0,
                                      maxValue: 23,
                                      listViewWidth: 60.0,
                                      onChanged: (val) 
                                      {
                                        setState(() 
                                        {
                                          min = val;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                //this is the seconds for the timer
                                Column
                                (
                                  children: <Widget>
                                  [
                                    Padding
                                    (
                                      padding: EdgeInsets.only
                                      (
                                        bottom: 5.0,
                                      ),
                                      child: Text("SEC"),
                                    ),
                                    NumberPicker.integer
                                    (
                                      initialValue: sec,
                                      minValue: 0,
                                      maxValue: 23,
                                      listViewWidth: 60.0,
                                      onChanged: (val) 
                                      {
                                        setState(() 
                                        {
                                          sec = val;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row
                            (
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>
                              [
                                RaisedButton
                                (
                                  onPressed: started ? start : null,
                                  color: Colors.green,
                                  child: Text("Start"),
                                ),
                                RaisedButton
                                (
                                  onPressed: stopped ? null : stop,
                                  color: Colors.red,
                                  child: Text("Stop"),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
