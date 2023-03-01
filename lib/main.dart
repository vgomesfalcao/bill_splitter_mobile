import 'package:bill_splitter/src/shared/repositories/jwt_auth_repository.dart';
import 'package:bill_splitter/src/shared/repositories/secure_storage_repository.dart';
import 'package:bill_splitter/src/views/login/login_page.dart';
import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const BillSplitter());
}

class BillSplitter extends StatelessWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.from(
          colorScheme: const ColorScheme.dark(
              primary: Colors.amber,
              secondary: Colors.amberAccent,
              onSecondaryContainer: Colors.amber,
              onSurface: Colors.amber,
              onSurfaceVariant: Colors.amber),
          useMaterial3: true,
        ),
        theme: ThemeData.from(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 2, 86, 119),
                onPrimary: Colors.white,
                secondary: Colors.blueGrey,
                surface: Color.fromARGB(255, 174, 219, 238),
                onSurface: Color.fromARGB(255, 0, 27, 37),
                surfaceVariant: Colors.white,
                outline: Color.fromARGB(255, 36, 104, 131)),
            useMaterial3: true),
        home: FutureBuilder(
          future: autoLogin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const BillNavigationBar();
              }
              if (snapshot.data == false) {
                return const LoginPage();
              }
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  Future<bool> autoLogin() async {
    SecureStorage secureStorage = SecureStorage();
    JwtAuth jwtAuth = JwtAuth();
    String? token = await secureStorage.getToken();
    if (token != null) {
      if (await jwtAuth.validateToken(token: token)) {
        return true;
      }
    }
    return false;
  }
}
