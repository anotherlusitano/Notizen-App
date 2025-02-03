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
      backgroundColor: Color.fromRGBO(253, 231, 172, 1),
      bottomNavigationBar: TextButton(
        onPressed: () => context.goNamed(Routes.signUp.name),
        child: Text(
          "Ainda não tens conta? Clica aqui!",
          style: TextStyle(
            color: Color.fromRGBO(159, 36, 30, 1),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/notizen.png",
                  height: 200,
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Insere o teu username...",
                      focusedBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Insere a tua password...",
                      hintStyle: Theme.of(context).textTheme.displaySmall,
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          passwordIsHidden = !passwordIsHidden;
                        }),
                        child: Icon(
                          passwordIsHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Color.fromRGBO(195, 108, 71, 1),
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
                    SnackMsg.showError(context, 'Verifique se a password ou o username estão certos!');
                  },
                  icon: Icon(
                    Icons.login,
                    color: Color.fromRGBO(195, 108, 71, 1),
                  ),
                  label: Text(
                    "Entrar",
                    style: TextStyle(
                      color: Color.fromRGBO(195, 108, 71, 1),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
