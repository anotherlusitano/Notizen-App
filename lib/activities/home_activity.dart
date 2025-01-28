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
          // HACK: we fetch the Todos again so when we go to another page it doesn't hide the DeleteButton
          // yes its bad code but this isn't a professional app so idc
          FutureBuilder(
            future: TodosRepository.instance.getTodos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                todos = snapshot.data!;

                return todos.any((todo) => todo.isDone.isOdd)
                    ? IconButton(
                        onPressed: () async {
                          for (final todo in todos) {
                            if (todo.isDone.isOdd) {
                              await TodosRepository.instance.deleteTodo(todo.id);
                            }
                          }

                          setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      )
                    : SizedBox();
              } else {
                return SizedBox();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => context.goNamed(Routes.login.name),
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      floatingActionButton: AddTodoButton(goAddTodo: () {
        context.goNamed(
          Routes.todo.name,
          pathParameters: {'todoId': todos.length.toString()},
        );
      }),
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
                                setState(() {
                                  todo.isDone = 1 - todo.isDone;

                                  TodosRepository.instance.updateTodoToDone(todo, todo.id).then((_) {
                                    setState(() {});
                                  });
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
