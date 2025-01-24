import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/models/category.dart';
import 'package:petpal_health/models/task.dart';
import 'package:petpal_health/provider/task_provider.dart';
import 'package:petpal_health/widgets/custom_input_field.dart';
import 'package:petpal_health/widgets/task_category_dropdown.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddTaskBottomSheet extends StatelessWidget {
  AddTaskBottomSheet({
    super.key,
  });

  Category? selectedCategory;

  final _taskNameController = TextEditingController();
  final _repetitionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 32.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add a task',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
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
                SizedBox(
                  width: double.infinity,
                  child: TaskCategoryDropdown(
                    onCategorySelected: (category) {
                      selectedCategory = category;
                    },
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: CustomInputField(
                        hintText: 'Repetition',
                        label: 'Repetition',
                        isPassword: false,
                        controller: _repetitionController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('times a day'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  final repetition =
                      int.tryParse(_repetitionController.text) ?? 1;

                  if (_taskNameController.text.isNotEmpty &&
                      selectedCategory != null) {
                    final newTask = Task(
                      name: _taskNameController.text,
                      category: selectedCategory!,
                      repetition: repetition,
                    );
                    Provider.of<TaskProvider>(context, listen: false)
                        .addTask(newTask);
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: kButtonColor,
                  foregroundColor: kTextColor,
                ),
                child: const Text(
                  'Save Task',
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
