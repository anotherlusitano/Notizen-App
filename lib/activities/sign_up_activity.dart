import 'package:flutter/material.dart';

class SignUpActivity extends StatelessWidget {
  const SignUpActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
