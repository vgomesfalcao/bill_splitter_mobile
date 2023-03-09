import 'package:bill_splitter/google_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginPageTitle = 'Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(loginPageTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final GoogleLogin googleLogin = GoogleLogin();
            googleLogin.handleSignIn();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text('Login with G+'),
        ),
      ),
    );
  }
}
