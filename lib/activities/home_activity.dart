import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';
import 'package:notizen/data/user_repository.dart';
import 'package:notizen/widgets/add_todo_button.dart';
import 'package:notizen/widgets/category_filter.dart';
import 'package:notizen/widgets/todo_box.dart';

import '../config/router.dart';

class HomeActivity extends StatefulWidget {
  final String? username;

  const HomeActivity({
    super.key,
    this.username,
  });

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  List<Todo> todos = [];
  String category = "todas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 231, 172, 1),
      appBar: AppBar(
        title: Text(
          "Tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(195, 108, 71, 1),
        actions: [
          // HACK: we fetch the Todos again so when we go to another page it doesn't hide the DeleteButton
          // yes its bad code but this isn't a professional app so idc
          FutureBuilder(
            future: TodosRepository.instance.getTodos(widget.username!, category),
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
                        icon: Icon(
                          Icons.delete,
                          color: Color.fromRGBO(159, 36, 30, 1),
                        ),
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
              onPressed: () async {
                final user = await UsersRepository.instance.getLocalAccount(widget.username!);

                await UsersRepository.instance.logoutLocalAccount(user!);

                if (!context.mounted) return;
                context.goNamed(Routes.login.name);
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: AddTodoButton(goAddTodo: () {
        context.goNamed(
          Routes.todo.name,
          pathParameters: {
            'todoId': todos.length.toString(),
            'todoOwner': widget.username!,
          },
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
                child: CategoryFilter(callback: (val) => setState(() => category = val)),
              ),
              Expanded(
                child: FutureBuilder(
                    future: TodosRepository.instance.getTodos(widget.username!, category),
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
