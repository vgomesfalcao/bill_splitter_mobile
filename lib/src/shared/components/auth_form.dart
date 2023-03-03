import 'dart:convert';

import 'package:bill_splitter/src/shared/repositories/token_auth.dart';
import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController userNameController = TextEditingController();
  final String userNameFieldText = 'Username';
  final String loginText = 'Login';
  final String passwordFieldText = 'Password';
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        BillTextField(
          text: userNameFieldText,
          controller: userNameController,
        ),
        BillTextField(
          text: passwordFieldText,
          controller: passwordController,
          obscureText: true,
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
                  print(value);
                  if (value == true) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const BillNavigationBar();
                    }));
                  }
                  if (value == false || value == null) {
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
    ));
  }

  Widget printMessages(http.Response value) {
    var messages = jsonDecode(value.body)['message'];
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
  const BillTextField(
      {super.key,
      this.text = '',
      required this.controller,
      this.obscureText = false});
  final String text;
  final TextEditingController controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: TextFormField(
        controller: controller,
        autocorrect: true,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: text,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
