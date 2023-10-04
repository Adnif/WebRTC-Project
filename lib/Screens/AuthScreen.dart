import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              margin: isKeyboard ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 165),
              child: Text(
                'LOGO',
                style: bold,
              ),
            ),
          ),
          AnimatedContainer(
            //height: 460,
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
            child: SingleChildScrollView(child: LoginContainer()),
          )
        ],
      ),
    );
  }
}

class LoginContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            'Welcome Back',
            style: headline,
          ),
          SizedBox(height: 10,),
          Text(
            'Fill your identity to login',
            style: subheader,
          ),
          SizedBox(height: 30,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Majesticon(Majesticon.mailLine, color: Colors.black,),
              ),
              labelText: 'Email',
              //labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 1)
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/icons/lock-line.svg',
                  
                ),
              ),
              labelText: 'Password',
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.white, width: 1)
              // ),
              //floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: bodyc,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
                //padding: EdgeInsets.only(left: 1, right: 1)
              )
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Need an account?",
                style: subheader,
              ),
              Text(
                'Create an account',
                style: subheader2,
              )
            ],
          ),
        ],
      ),
    );
  }
}