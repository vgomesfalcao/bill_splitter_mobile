import 'dart:convert';

import 'package:bill_splitter/src/shared/repositories/secure_storage_repository.dart';
import 'package:http/http.dart' as http;

class JwtAuth {
  final String url = 'http://10.0.2.2:3000/login';
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  Future<http.Response> login(
      {required String username, required String password}) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(
          <String, String>{"email": username, "password": password},
        ));
    if (response.statusCode == 200) {
      SecureStorage secureStorage = SecureStorage();
      secureStorage.save(
          key: 'token', value: jsonDecode(response.body)['access_token']);
    }
    return response;
  }

  Future<bool> validateToken({required String token}) async {
    String validateUrl = 'http://10.0.2.2:3000/validate';
    headers.addAll({'Authorization': 'Bearer $token'});
    http.Response response =
        await http.post(Uri.parse(validateUrl), headers: headers);
    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
    }
  }
}
