import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bill_splitter/src/shared/services/jwt_auth_service.dart';

class TokenAuth {
  JwtAuth jwtAuth = JwtAuth();

  Future<http.Response> getToken(
      {required String username, required String password}) async {
    Uri loginUrl = jwtAuth.generateUri(path: 'login');
    http.Response response = await http.post(loginUrl,
        headers: jwtAuth.headers,
        body: jsonEncode(
          <String, String>{"email": username, "password": password},
        ));
    if (response.statusCode == 200) {
      jwtAuth.secureStorage
          .saveToken(value: jsonDecode(response.body)['access_token']);
    }
    return response;
  }

  Future<bool?> validateToken() async {
    Uri validateUrl = jwtAuth.generateUri(path: 'validate');
    String? token = await jwtAuth.secureStorage.getToken();
    Map<String, String> headers = jwtAuth.headers;
    headers.addAll({'Authorization': 'Bearer $token'});
    print('validando...');
    try {
      http.Response response =
          await http.post(validateUrl, headers: jwtAuth.headers);

      if (response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
