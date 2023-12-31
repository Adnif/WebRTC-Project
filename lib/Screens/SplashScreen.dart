import 'dart:async';
import 'dart:math';

import 'package:bcall/Screens/AuthScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:bcall/services/SignallingService.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      goToAuthScreen(context);
    });
  }

  void goToAuthScreen(BuildContext context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthScreen()
      )  
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 300,),
          Center(
            child: Text(
              'LOGO',
              style: boldGreen,
            ),
          ),
          SizedBox(height: 300,),
          Center(
            child: Column(
              
              children: [
                Text(
                  'FROM',
                  style: mediumBlack,
                ),
                Text(
                  'BP JAMSOSTEK',
                  style: mediumBlack,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
