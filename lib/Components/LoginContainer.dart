import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bcall/Models/AuthModels.dart';
import 'package:bcall/Providers/AuthProvider.dart';
import 'package:bcall/Screens/HomeScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:bcall/services/SignallingService.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

class LoginContainer extends ConsumerStatefulWidget{
  //const LoginContainer({super.key});

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends ConsumerState<LoginContainer>{
  bool showEyedIcon = true;

  //this icon function
  void toggleIcon(){
    setState(() {
      showEyedIcon = !showEyedIcon;
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isButtonDisabled = true;
  bool isPasswordFilled = false;
  bool isEmailFilled = false;

  void checkEmailPass(){
    if(isEmailFilled && isPasswordFilled){
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                'Welcome Back',
                style: headlineBlack,
              ),
              SizedBox(height: 10,),
              Text(
                'Fill you identity to login',
                style: subheaderBlack,
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Majesticon(Majesticon.mailLine, color: Colors.black,),
                  ),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white
                ),
                validator: (email){
                   return EmailValidator.validate(email!) ? null : 'Masukan Email dengan benar!';
                },
                onChanged: (val){
                  if(val.isNotEmpty){
                      setState(() {
                        isEmailFilled = true;
                    });
                  } else {
                    setState(() {
                      isEmailFilled = false;
                    });
                  }
                  checkEmailPass();
                },
        
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: showEyedIcon,
                decoration: InputDecoration(
                  prefixIcon:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Majesticon(Majesticon.lockLine, color: Colors.black,),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: toggleIcon,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: showEyedIcon ? const Iconify(Octicon.eye_closed_24) : const Iconify(Octicon.eye_24),
                    ),
                  ),
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white
                ),
                validator: (pass){
                  if (pass != null && (pass.length >= 6 && pass.length <= 12)) {
                    return null; // Password is valid
                  } else {
                    return 'Password must be between 6 and 12 characters';
                  }
                },
                onChanged: (val){
                  if(val.isNotEmpty){
                      setState(() {
                        isPasswordFilled = true;
                    });
                  } else {
                    setState(() {
                      isPasswordFilled = false;
                    });
                  }
                  checkEmailPass();
                },
              ),
              SizedBox(height: 35,),
              Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonDisabled ? null : () async {
                    if (_formKey.currentState != null && _formKey.currentState!.validate() && !isButtonDisabled) {
                      final loginResult = await ref.watch(authProvider).login(emailController.text, passwordController.text);
                      
                      if(loginResult.token == null){
                        print(loginResult.statusCode);
                      } else {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('token', loginResult.token!);
                        log('log yang disimpan: ${loginResult.token!}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          )
                        );
                      }
                    } else {
                      setState(() {
                        isButtonDisabled = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  green,
                    disabledBackgroundColor: bodyc,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    )
                    //padding: EdgeInsets.only(left: 1, right: 1)
                  ),
                  child: Text(
                    'Login',
                    style: subheader2,
                  )
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}