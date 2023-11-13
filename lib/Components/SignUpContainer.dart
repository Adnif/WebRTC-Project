import 'dart:developer';

import 'package:bcall/Providers/AuthProvider.dart';
import 'package:bcall/Screens/AuthScreen.dart';
import 'package:bcall/Screens/HomeScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';


class SignUpContainer extends ConsumerStatefulWidget{
  @override
  _SignUpContainerState createState() => _SignUpContainerState();
}

class _SignUpContainerState extends ConsumerState<SignUpContainer>{
  bool showEyedIcon = true;

  void toggleIcon(){
    setState(() {
      showEyedIcon = !showEyedIcon;
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isButtonDisabled = true;

  bool isPasswordFilled = false;
  bool isEmailFilled = false;
  bool isUsernameFilled = false;
  bool isPhoneFilled = false;

  void checkCredentials(){
    if(isEmailFilled && isPasswordFilled && isUsernameFilled && isPhoneFilled){
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
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text(
              'Create Account',
              style: headline,
            ),
            SizedBox(height: 10,),
            Text(
              'Create your account to access this apps',
              style: subheader,
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
                checkCredentials();
              },
        
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Iconify(RadixIcons.person),
                ),
                labelText: 'Username',
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
              validator: (username){
                 return (username!.length > 3 && username.length < 12) ? null : 'Masukan Email dengan benar!';
              },
              onChanged: (val){
                if(val.isNotEmpty){
                    setState(() {
                      isUsernameFilled = true;
                  });
                } else {
                  setState(() {
                    isUsernameFilled = false;
                  });
                }
                checkCredentials();
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
                checkCredentials();
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Iconify(Carbon.phone),
                ),
                labelText: 'Phone Number',
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
              onChanged: (val){
                if(val.isNotEmpty){
                    setState(() {
                      isPhoneFilled = true;
                  });
                } else {
                  setState(() {
                    isPhoneFilled = false;
                  });
                }
                checkCredentials();
              },
        
            ),
            SizedBox(height: 20,),
            Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonDisabled ? null : () async {
                  if (_formKey.currentState != null && _formKey.currentState!.validate() && !isButtonDisabled) {
                    final signupResult = await ref.watch(authProvider).signup(usernameController.text, emailController.text, passwordController.text, phoneController.text);

                    if(signupResult == '201'){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          )
                        );
                    } else {
                      log('$signupResult');
                      Fluttertoast.showToast(msg: signupResult!);
                    }
                  } else {
                    setState(() {
                      isButtonDisabled = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  primary,
                  disabledBackgroundColor: bodyc,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                  //padding: EdgeInsets.only(left: 1, right: 1)
                ),
                child: Text(
                  'Sign Up',
                  style: subheader2,
                )
              ),
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}