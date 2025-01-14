import 'package:flutter/material.dart';

class LoginActivity extends StatelessWidget {
  const LoginActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
