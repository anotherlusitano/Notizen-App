import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/data/categories.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';

import '../config/router.dart';

List<String> categories = Category.values.map((e) => e.name).toList();

class TodoActivity extends StatefulWidget {
  const TodoActivity({super.key});

  @override
  State<TodoActivity> createState() => _TodoActivityState();
}

class _TodoActivityState extends State<TodoActivity> {
  final TextEditingController _textController = TextEditingController();

  String category = categories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Tarefa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () => context.goNamed(Routes.home.name),
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

                    final todo = Todo(todoText, category, 0);
                    await TodosRepository.instance.createTodo(todo);

                    if (!context.mounted) return;

                    context.goNamed(Routes.home.name);
                  },
                  icon: Icon(Icons.create),
                  label: Text("Criar tarefa"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
