import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final String text;
  final Function selectCategory;

  const CategoryBox({
    super.key,
    required this.text,
    required this.selectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => selectCategory(text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
