import 'dart:math';

import 'package:bcall/Models/AuthModels.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final authProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  //Login Controller
  Future<LoginResults> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5001/api/auth/login'), // Replace with your server URL
      //Uri.parse('http://localhost:5001/api/auth/login'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mail': email,
        'password': password,
      }),
    );

    LoginResults results;

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return results =  LoginResults(statusCode: response.statusCode.toString(), token: data['userDetails']['token'].toString()); //data['userDetails']['token'].toString();
    } else {
      return results = LoginResults(statusCode: response.body);
      //throw Exception('Failed to login').toString();
    }
  }

  //Sign Up Controller
  Future<String?> signup(String username, String email, String password, String phoneNum) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5001/api/auth/register'), // Replace with your server's signup URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'mail': email,
        'password': password,
        'phonenum': phoneNum
      }),
    );

    log(response.statusCode);
    return response.statusCode.toString();
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> data = json.decode(response.body);
    //   return data['userDetails']['token'];
    // } else {
    //   log(response.statusCode);
    //   return response.body.toString();
    //   //throw Exception('Failed to signup');
    // }
  }
}

