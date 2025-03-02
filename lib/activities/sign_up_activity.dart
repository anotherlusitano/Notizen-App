import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/user.dart';
import 'package:notizen/data/user_repository.dart';
import 'package:notizen/widgets/snackbar.dart';

import '../config/router.dart';

class SignUpActivity extends StatefulWidget {
  const SignUpActivity({super.key});

  @override
  State<SignUpActivity> createState() => _SignUpActivityState();
}

class _SignUpActivityState extends State<SignUpActivity> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 231, 172, 1),
      bottomNavigationBar: TextButton(
        onPressed: () => context.goNamed(Routes.login.name),
        child: Text(
          "Já tens conta? Clica aqui!",
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
                      focusedBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final String password = _passwordController.text;
                      final String username = _usernameController.text;

                      if (password.trim().isEmpty || username.trim().isEmpty) return;

                      final userFound = await UsersRepository.instance.getLocalAccount(username);

                      if (userFound != null) {
                        if (!context.mounted) return;
                        return SnackMsg.showInfo(context, 'Este utilizador já existe!');
                      }

                      final user = User(username, password, 1);

                      UsersRepository.instance.createLocalAccount(user);

                      if (!context.mounted) return;
                      SnackMsg.showOk(context, 'Utilizador criado. Bem-vindo $username!');

                      return context.goNamed(
                        Routes.home.name,
                        pathParameters: {'username': username},
                      );
                    },
                    icon: Icon(
                      Icons.create,
                      color: Color.fromRGBO(195, 108, 71, 1),
                    ),
                    label: Text(
                      "Criar",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
