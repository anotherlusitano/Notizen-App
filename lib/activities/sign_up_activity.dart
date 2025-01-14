import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/router.dart';

class SignUpActivity extends StatelessWidget {
  SignUpActivity({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Cria a tua conta!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insere o teu username...",
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insere a tua password...",
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint(_passwordController.text);
                    debugPrint(_usernameController.text);
                    if (_passwordController.text.trim().isEmpty || _usernameController.text.trim().isEmpty) return;

                    // TODO: create local authentication

                    context.goNamed(Routes.home.name);
                  },
                  icon: Icon(Icons.create),
                  label: Text("Criar"),
                ),
              ),
              TextButton(
                onPressed: () => context.goNamed(Routes.login.name),
                child: Text("Já tens conta? Clica aqui!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
