import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/categories.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';

import '../config/router.dart';

List<String> categories = Category.values.map((e) => e.name).toList();

class TodoActivity extends StatefulWidget {
  final String? todoId;
  final String? todoOwner;

  const TodoActivity({
    super.key,
    this.todoId,
    this.todoOwner,
  });

  @override
  State<TodoActivity> createState() => _TodoActivityState();
}

class _TodoActivityState extends State<TodoActivity> {
  final TextEditingController _textController = TextEditingController();

  String category = categories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 231, 172, 1),
      appBar: AppBar(
        title: Text(
          "Criar Tarefa",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(195, 108, 71, 1),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () => context.goNamed(
              Routes.home.name,
              pathParameters: {'username': widget.todoOwner!},
            ),
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insira a tarefa...",
                    focusedBorder: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              DropdownMenu(
                initialSelection: category,
                dropdownMenuEntries: categories.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                label: Text("Categoria"),
                onSelected: (String? value) {
                  category = value!;
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final String todoText = _textController.text;

                    if (todoText.trim().isEmpty) return;

                    int todoId = int.parse(widget.todoId!);

                    final todo = Todo(todoId, widget.todoOwner!, todoText, category, 0);
                    await TodosRepository.instance.createTodo(todo);

                    if (!context.mounted) return;

                    context.goNamed(
                      Routes.home.name,
                      pathParameters: {'username': widget.todoOwner!},
                    );
                  },
                  icon: Icon(
                    Icons.create,
                    color: Color.fromRGBO(195, 108, 71, 1),
                  ),
                  label: Text(
                    "Criar tarefa",
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
    );
  }
}
