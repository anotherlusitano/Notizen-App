import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => (),
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
