import 'package:bill_splitter/src/shared/repositories/secure_storage_repository.dart';

class JwtAuth {
  final String url = 'http://10.0.2.2:3000';
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  final SecureStorage secureStorage = SecureStorage();

  Uri generateUri({required String path}) {
    return Uri.parse('$url/$path');
  }
}
