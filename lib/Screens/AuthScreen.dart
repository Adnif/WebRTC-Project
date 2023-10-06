import 'package:bcall/Components/LoginContainer.dart';
import 'package:bcall/Components/SignUpContainer.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/clarity.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleSignUp(){
    setState(() {
      isLogin = !isLogin;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: isKeyboard 
                ? EdgeInsets.only(bottom: 0) 
                : isLogin 
                  ? EdgeInsets.only(bottom: 165)
                  : EdgeInsets.only(bottom: 59),
              child: Text(
                'LOGO',
                style: bold,
              ),
            ),
          ),
          AnimatedContainer(
            height: isLogin ? 460 : 612,
            padding: EdgeInsetsDirectional.only(bottom: 0),
            //color: secondary,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              color:secondary,
              //border: Border.all(color: secondary, width: 5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              )
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  isLogin ? LoginContainer() : SignUpContainer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Need an account?",
                        style: subheader,
                      ),
                      GestureDetector(
                        onTap: toggleSignUp,
                        child: Text(
                          'Create an account',
                          style: subheader2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



