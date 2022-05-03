import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plastic_recorder/login_screen.dart';
import 'package:plastic_recorder/today_screen.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen({ Key? key }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context)=>
      Scaffold(
      body:StreamBuilder<User?>(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            return Today() ;
          }else{
            return LoginScreen();
          }
           
        }
      )
    );
  }
