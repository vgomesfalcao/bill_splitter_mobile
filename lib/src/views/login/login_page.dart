import 'dart:convert';

import 'package:bill_splitter/src/shared/repositories/jwt_auth_repository.dart';
import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const loginText = 'Login';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      loginText,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              BillTextField(
                text: 'Username',
                controller: userNameController,
              ),
              BillTextField(
                text: 'Password',
                controller: passwordController,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    JwtAuth authRepository = JwtAuth();
                    Future<http.Response> authenticated = authRepository.login(
                        username: userNameController.text,
                        password: passwordController.text);
                    authenticated.then((value) {
                      if (value.statusCode == 200) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const BillNavigationBar();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: printMessages(value),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: const Text(
                    loginText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget printMessages(http.Response value) {
    var messages = jsonDecode(value.body)['message'];
    if (value.body is List) {
      return Column(
          children: List.generate(messages.length, (index) {
        return Text(messages[index].toString());
      }));
    }
    return Text(messages);
  }
}

class BillTextField extends StatelessWidget {
  const BillTextField({super.key, this.text = '', required this.controller});
  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: TextField(
        controller: controller,
        autocorrect: true,
        decoration: InputDecoration(
            hintText: text,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
