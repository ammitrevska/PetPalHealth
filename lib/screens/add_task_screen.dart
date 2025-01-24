import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/models/category.dart';
import 'package:petpal_health/widgets/custom_input_field.dart';
import 'package:petpal_health/widgets/task_category_dropdown.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _repetitionController = TextEditingController();
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 32.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Add a task',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  hintText: 'Name of task',
                  label: 'Name of task',
                  isPassword: false,
                  controller: _taskNameController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text('Category'),
                TaskCategoryDropdown(
                  onCategorySelected: (Category category) {
                    _selectedCategory = category;
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: CustomInputField(
                        hintText: 'Repetition',
                        label: 'Repetition',
                        isPassword: false,
                        controller: _repetitionController,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text('times a day'),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  final taskName = _taskNameController.text.trim();
                  final repetition =
                      int.tryParse(_repetitionController.text.trim());
                  if (taskName.isNotEmpty &&
                      _selectedCategory != null &&
                      repetition! > 0) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields!')),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: kButtonColor,
                  foregroundColor: kTextColor,
                ),
                child: const Text(
                  'Add task',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
