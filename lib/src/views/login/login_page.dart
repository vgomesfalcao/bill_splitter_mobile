import 'dart:convert';

import 'package:bill_splitter/src/shared/repositories/token_auth_repository.dart';
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
  final String loginText = 'Login';
  final String userNameFieldText = 'Username';
  final String passwordFieldText = 'Password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 25),
              child: SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/BillSplit.png'),
                  )),
            ),
            BillTextField(
              text: userNameFieldText,
              controller: userNameController,
            ),
            BillTextField(
              text: passwordFieldText,
              controller: passwordController,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  TokenAuth tokenauthRepository = TokenAuth();
                  http.Response response = await tokenauthRepository.getToken(
                      username: userNameController.text,
                      password: passwordController.text);
                  if (response.statusCode == 200) {
                    TokenAuth tokenAuth = TokenAuth();
                    tokenAuth.validateToken().then((value) {
                      if (value == true) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const BillNavigationBar();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: printMessages(response),
                          ),
                        );
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text(
                  loginText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget printMessages(http.Response value) {
    var messages = jsonDecode(value.body)['message'];
    if (value.statusCode == 200) {
      return Text(value.body);
    }
    if (messages is List) {
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
