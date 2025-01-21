import 'package:flutter/material.dart';
import 'package:notizen/widgets/category_box.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryBox(text: "todas"),
            CategoryBox(text: "trabalho"),
            CategoryBox(text: "pessoal"),
            CategoryBox(text: "estudos"),
            CategoryBox(text: "entre"),
            CategoryBox(text: "outros"),
            CategoryBox(text: "emojis"),
          ],
        ),
      ),
    );
  }
}
