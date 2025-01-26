import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';
import 'package:notizen/widgets/add_todo_button.dart';
import 'package:notizen/widgets/category_filter.dart';
import 'package:notizen/widgets/todo_box.dart';

import '../config/router.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
        backgroundColor: Colors.blue,
        actions: [
          todos.any((todo) => todo.isDone.isOdd)
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () => (),
                    icon: Icon(Icons.delete),
                  ),
                )
              : SizedBox(),
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
                        todos = snapshot.data!;

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var todo = snapshot.data![index];

                              callback() {
                                setState(() async {
                                  todo.isDone = 1 - todo.isDone;

                                  await TodosRepository.instance.updateTodoToDone(todo, index + 1);

                                  setState(() {});
                                });
                              }

                              return TodoBox(todo: todo, callBack: callback);
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
