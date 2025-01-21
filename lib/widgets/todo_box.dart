import 'package:flutter/material.dart';

class TodoBox extends StatefulWidget {
  const TodoBox({
    super.key,
  });

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () => setState(() {
          isDone = !isDone;
        }),
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
            if (isDone) {
              return Colors.white10;
            }
            return Colors.white30;
          }),
        ),
        child: Text(
          "HOME",
          style: TextStyle(
            color: isDone ? Colors.black54 : Colors.black,
            decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
