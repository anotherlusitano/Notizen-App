import 'package:flutter/material.dart';
import 'package:notizen/data/todo.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () async => await widget.callBack(),
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
