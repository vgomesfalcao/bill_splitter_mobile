import 'package:bill_splitter/src/shared/repositories/secure_storage.dart';

class JwtAuth {
  final String url = 'http://134.65.242.199:3000';
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  final SecureStorage secureStorage = SecureStorage();

  Uri generateUri({required String path}) {
    return Uri.parse('$url/$path');
  }
}
