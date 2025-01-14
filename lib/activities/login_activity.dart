import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/router.dart';

class LoginActivity extends StatelessWidget {
  LoginActivity({super.key});

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
                "Bem-vindo!",
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
              ElevatedButton.icon(
                onPressed: () {
                  debugPrint(_passwordController.text);
                  debugPrint(_usernameController.text);
                  if (_passwordController.text.trim().isEmpty || _usernameController.text.trim().isEmpty) return;

                  // TODO: create local authentication

                  context.goNamed(Routes.home.name);
                },
                icon: Icon(Icons.login),
                label: Text("Entrar"),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2.0,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "ou então",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: create google authentication

                  context.goNamed(Routes.home.name);
                },
                child: Text("Botão do Google"),
              ),
              TextButton(
                onPressed: () => context.goNamed(Routes.signUp.name),
                child: Text("Ainda não tens conta? Clica aqui!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
