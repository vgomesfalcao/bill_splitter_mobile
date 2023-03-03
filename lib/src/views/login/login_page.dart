import 'package:bill_splitter/src/shared/components/auth_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String loginText = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8, bottom: 25),
              child: SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/BillSplit.png'),
                  )),
            ),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}
