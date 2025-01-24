import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/todo_repositoy.dart';
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
        backgroundColor: Colors.blue,
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
              SizedBox(
                height: 50.0,
                child: CategoryFilter(),
              ),
              Expanded(
                child: FutureBuilder(
                    future: TodosRepository.instance.getTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final todo = snapshot.data![index];

                              return TodoBox(todo: todo, index: index + 1);
                            });
                      } else {
                        return SizedBox();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
