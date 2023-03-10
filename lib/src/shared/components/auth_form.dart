import 'dart:convert';
import 'package:bill_splitter/src/shared/repositories/token_auth.dart';
import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String userNameFieldText = 'Username';
  final String loginText = 'Login';
  final String passwordFieldText = 'Password';
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Carregando...'),
            duration: Duration(milliseconds: 500)),
      );
    } else {
      return;
    }
    setState(() => _isLoading = true);

    TokenAuth tokenauthRepository = TokenAuth();
    http.Response response = await tokenauthRepository.getToken(
        username: userNameController.text, password: passwordController.text);

    if (response.statusCode == 200) {
      TokenAuth tokenAuth = TokenAuth();
      tokenAuth.validateToken().then((value) {
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
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  BillTextField(
                    text: userNameFieldText,
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um nome de usuário';
                      }
                      return null;
                    },
                  ),
                  BillTextField(
                    text: passwordFieldText,
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite uma senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      child: Text(
                        loginText,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
      this.obscureText = false,
      required this.validator});
  final String text;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: TextFormField(
        controller: controller,
        autocorrect: true,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(hintText: text),
      ),
    );
  }
}
