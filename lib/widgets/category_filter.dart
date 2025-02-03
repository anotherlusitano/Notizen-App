import 'package:flutter/material.dart';
import 'package:notizen/data/categories.dart';
import 'package:notizen/widgets/category_box.dart';

class CategoryFilter extends StatefulWidget {
  final Function callback;

  const CategoryFilter({
    super.key,
    required this.callback,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final List<Category> categories = Category.values.toList();
  final List<bool> enabledList = Category.values.map((category) => category.enabled).toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                enabledList.fillRange(0, enabledList.length, false);
                enabledList[index] = true;
                widget.callback(categories[index].name);
              });
            },
            child: CategoryBox(
              enabled: enabledList[index],
              category: categories[index],
              selectCategory: widget.callback,
            ),
          );
        },
      ),
    );
  }
}
