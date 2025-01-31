import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/user.dart';
import 'package:notizen/data/user_repository.dart';
import 'package:notizen/widgets/snackbar.dart';

import '../config/router.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key});

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  bool passwordIsHidden = true;

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
                  obscureText: passwordIsHidden,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insere a tua password...",
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                    suffixIcon: InkWell(
                      onTap: () => setState(() {
                        passwordIsHidden = !passwordIsHidden;
                      }),
                      child: Icon(
                        passwordIsHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final String password = _passwordController.text;
                  final String username = _usernameController.text;

                  if (password.trim().isEmpty || username.trim().isEmpty) return;

                  final user = User(username, password, 0);

                  final userFound = await UsersRepository.instance.loginLocalAccount(user);

                  if (userFound) {
                    if (!context.mounted) return;
                    SnackMsg.showOk(context, 'Bem-vindo $username!');
                    return context.goNamed(
                      Routes.home.name,
                      pathParameters: {'username': username},
                    );
                  }

                  if (!context.mounted) return;
                  SnackMsg.showError(context, 'Palavra-passe ou username errado!');
                },
                icon: Icon(Icons.login),
                label: Text("Entrar"),
              ),
              SizedBox(height: 20.0),
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
