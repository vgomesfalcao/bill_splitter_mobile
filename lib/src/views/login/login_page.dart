import 'package:bill_splitter/src/shared/components/auth_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String loginText = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        offset: const Offset(0, -40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 25),
                    child: Image(
                      image: getLogoImage(context),
                    ),
                  ),
                ),
              const AuthForm(),
            ],
          ),
        ),
      ),
    );
  }

  AssetImage getLogoImage(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return const AssetImage('assets/bill_split_dark.png');
    }
    return const AssetImage('assets/bill_split_light.png');
  }
}
