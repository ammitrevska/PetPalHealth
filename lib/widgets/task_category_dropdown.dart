import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/models/category.dart';

class TaskCategoryDropdown extends StatefulWidget {
  final Function(Category) onCategorySelected;

  const TaskCategoryDropdown({super.key, required this.onCategorySelected});

  @override
  State<TaskCategoryDropdown> createState() => _TaskCategoryDropdownState();
}

class _TaskCategoryDropdownState extends State<TaskCategoryDropdown> {
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
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
        if (_selectedCategory != null) {
          widget.onCategorySelected(_selectedCategory!);
        }
      },
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
