import 'dart:convert';

import 'package:http/http.dart' as http;

class JwtAuth {
  final String url = 'http://10.0.2.2:3000/login';
  Future<http.Response> login(
      {required String username, required String password}) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"email": username, "password": password},
        ));
    return response;
  }
}
