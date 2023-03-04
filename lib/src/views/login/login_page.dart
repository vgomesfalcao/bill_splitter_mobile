import 'package:bill_splitter/src/shared/components/auth_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String loginText = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        offset: Offset(0, -40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 25),
                child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      image: AssetImage('assets/BillSplit.png'),
                    )),
              ),
              const AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
