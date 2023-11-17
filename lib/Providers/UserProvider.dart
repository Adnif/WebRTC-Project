import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

final String baseURL = 'http://10.0.2.2:5001/api/';
//final String baseURL = 'http://192.168.17.160:5001/api/';
//final String baseURL = 'http://localhost:5001/api/';

class UserProvider{
  Future<Response> getUser(String token) async {
    final url = Uri.parse('${baseURL}user/getUser');
    final response = await get(
      url, // Replace with your server's signup URL
      headers: <String, String>{
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      //Map<String, dynamic> data = json.decode(response.body);
      return response;
    } else {
      log('${response.body.toString()}');
      throw Exception('Failed to get');
    }
  }

  Future<Response> addFriend(String token, String phonenum) async {
    final url = Uri.parse('${baseURL}user/addFriend');
    final response = await post(
      url, // Replace with your server's signup URL
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phonenum': phonenum,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 404) {
      //Map<String, dynamic> data = json.decode(response.body);
      return response;
    } else {
      log('${response.body.toString()}');
      throw Exception('Failed to post');
    }
  }
}

