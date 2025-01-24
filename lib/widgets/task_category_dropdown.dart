import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/models/category.dart';

// ignore: must_be_immutable
class TaskCategoryDropdown extends StatelessWidget {
  final Function(Category) onCategorySelected;

  TaskCategoryDropdown({required this.onCategorySelected, super.key});

  Category? _selectedCategory;

  final List<Category> _categories = [
    Category(name: 'Food', icon: Icons.fastfood),
    Category(name: 'Snack', icon: Icons.local_pizza),
    Category(name: 'Medications', icon: Icons.medical_services),
    Category(name: 'Water', icon: Icons.water_drop),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      hint: const Text('Select Category'),
      value: _selectedCategory,
      onChanged: (Category? newCategory) {
        if (newCategory != null) {
          onCategorySelected(newCategory);
        }
      },
      // decoration: InputDecoration(
      //   labelText: 'Category',
      //   filled: true,
      //   fillColor: Colors.white,
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: const BorderSide(
      //       color: Colors.transparent,
      //       width: 0,
      //     ),
      //     borderRadius: BorderRadius.circular(15.0),
      //   ),
      // ),
      items: _categories.map((category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Row(
            children: [
              Icon(
                category.icon,
                color: kTextColor,
              ),
              const SizedBox(width: 8.0),
              Text(category.name),
            ],
          ),
        );
      }).toList(),
    );
  }
}
