import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  final Function() goAddTodo;

  const AddTodoButton({
    super.key,
    required this.goAddTodo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => goAddTodo(),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(195, 108, 71, 1)),
      ),
      child: Text(
        "+",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
