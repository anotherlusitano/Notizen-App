import 'package:flutter/material.dart';
import 'package:notizen/data/categories.dart';

class CategoryBox extends StatefulWidget {
  final bool enabled;
  final Category category;
  final Function selectCategory;

  const CategoryBox({
    super.key,
    required this.enabled,
    required this.category,
    required this.selectCategory,
  });

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: widget.enabled ? Colors.black : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: widget.enabled ? Colors.white : Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.category.text,
            style: TextStyle(
              color: widget.enabled ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
