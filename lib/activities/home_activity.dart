import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/widgets/add_todo_button.dart';
import 'package:notizen/widgets/category_filter.dart';
import 'package:notizen/widgets/todo_box.dart';

import '../config/router.dart';

class HomeActivity extends StatelessWidget {
  const HomeActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => context.goNamed(Routes.login.name),
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      floatingActionButton: AddTodoButton(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CategoryFilter(),
              TodoBox(),
            ],
          ),
        ),
      ),
    );
  }
}
