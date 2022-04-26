import 'package:flutter/material.dart';
import 'package:plastic_recorder/calender.dart';
import 'package:plastic_recorder/compare.dart';
import 'package:plastic_recorder/firstpage.dart';
import 'package:plastic_recorder/login_screen.dart';
import 'package:plastic_recorder/recommend.dart';
import 'package:plastic_recorder/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      routes: {
        '/':(context) => firstPage(),
        '/login': (context) => LoginScreen(),
        '/register' :(context) => register(),
        '/calender' :(context) => calender(),
        '/compare' :(context) => Compare(),
        '/recommendation' :(context) => Recommend(),
        //'/profile' :(context) => (),
        //'/add' :(context) => Add(), 
        //'/today' : (context) => today(),
        
      
      },
       

      );
  }
}
