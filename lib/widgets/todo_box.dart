import 'package:flutter/material.dart';
import 'package:notizen/data/categories.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';

class TodoBox extends StatefulWidget {
  final Todo todo;
  final Function() callBack;

  const TodoBox({
    super.key,
    required this.todo,
    required this.callBack,
  });

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(5.0),
      child: ElevatedButton(
        onPressed: () => widget.callBack(),
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.black,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((_) {
            if (widget.todo.isDone.isOdd) {
              return Colors.white10;
            }
            return Colors.white30;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.todo.name,
                style: TextStyle(
                  color: widget.todo.isDone.isOdd ? Colors.black54 : Colors.black,
                  decoration: widget.todo.isDone.isOdd ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () => editTodo(context, widget.todo),
              icon: Icon(Icons.edit),
              iconSize: 24,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  editTodo(BuildContext context, Todo todo) {
    List<String> categories = Category.values.map((e) => e.name).toList();

    final TextEditingController textController = TextEditingController(
      text: todo.name,
    );

    String category = todo.category;

    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Color.fromRGBO(195, 108, 71, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              "Editar tarefa",
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
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
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              onSelected: (String? value) {
                category = value!;
                setState(() {});
              },
            ),
            TextButton(
              onPressed: () async {
                final String todoText = textController.text;

                if (todoText.trim().isEmpty) return;

                todo.name = todoText;
                todo.category = category;

                await TodosRepository.instance.updateTodo(todo);

                if (!context.mounted) return;

                Navigator.pop(context);

                setState(() {});
              },
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: Color.fromRGBO(253, 231, 172, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
