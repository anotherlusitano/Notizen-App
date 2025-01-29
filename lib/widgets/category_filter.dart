import 'package:flutter/material.dart';
import 'package:notizen/data/categories.dart';
import 'package:notizen/widgets/category_box.dart';

class CategoryFilter extends StatelessWidget {
  final Function callback;

  CategoryFilter({
    super.key,
    required this.callback,
  });

  final List<String> categories = Category.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryBox(text: categories[index], selectCategory: callback);
          },
        ),
      ),
    );
  }
}
