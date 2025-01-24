import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notizen/config/router.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.goNamed(Routes.todo.name);
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
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
