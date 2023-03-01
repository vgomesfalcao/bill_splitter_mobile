import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = const FlutterSecureStorage();

  void save({required String key, required String value}) async {
    await storage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }

  Future<String?> getToken() async {
    String? value =
        await storage.read(key: 'token', aOptions: _getAndroidOptions());
    return value;
  }
}
