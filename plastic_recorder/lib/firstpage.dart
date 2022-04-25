import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plastic_recorder/login_screen.dart';

class firstPage extends StatefulWidget {
  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  initScreen(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color(0xffFF9F1D),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/appIcon.png'),
            Text(
              'Plastic Recorder',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
    ));
  }
}
