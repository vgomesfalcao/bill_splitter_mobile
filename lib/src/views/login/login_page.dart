import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
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
                text: 'Login',
                controller: loginController,
              ),
              BillTextField(
                text: 'Password',
                controller: passwordController,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
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
