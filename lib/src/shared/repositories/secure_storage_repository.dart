import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void saveToken({required String value}) async {
    await storage.write(
        key: 'token', value: value, aOptions: _getAndroidOptions());
  }

  Future<String?> getToken() async {
    String? value =
        await storage.read(key: 'token', aOptions: _getAndroidOptions());
    return value;
  }
}
