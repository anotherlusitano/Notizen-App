import 'package:flutter/material.dart';
import 'package:notizen/data/todo.dart';
import 'package:notizen/data/todo_repositoy.dart';

class TodoBox extends StatefulWidget {
  final Todo todo;
  final int index;

  const TodoBox({
    super.key,
    required this.todo,
    required this.index,
  });

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () async {
          widget.todo.isDone = 1 - widget.todo.isDone;

          await TodosRepository.instance.updateTodoToDone(widget.todo, widget.index);

          setState(() {});
        },
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
        child: Text(
          widget.todo.name,
          style: TextStyle(
            color: widget.todo.isDone.isOdd ? Colors.black54 : Colors.black,
            decoration: widget.todo.isDone.isOdd ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
