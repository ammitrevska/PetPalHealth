import 'package:flutter/material.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/widgets/custom_input_field.dart';

class AddEventBottomsheet extends StatelessWidget {
  AddEventBottomsheet({super.key});

  final _eventNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();

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
              'Add an Event',
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
                  hintText: 'Title',
                  label: 'Title',
                  isPassword: false,
                  controller: _eventNameController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    //TODO: add icons
                    Flexible(
                      fit: FlexFit.loose,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          );

                          if (selectedDate != null) {
                            _dateController.text =
                                '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomInputField(
                            hintText: 'Date',
                            label: 'Date',
                            isPassword: false,
                            controller: _dateController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: GestureDetector(
                        onTap: () async {
                          TimeOfDay? selectedtime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (selectedtime != null) {
                            _timeController.text =
                                '${selectedtime.hour} : ${selectedtime.minute}';
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomInputField(
                            hintText: 'Time',
                            label: 'Time',
                            isPassword: false,
                            controller: _dateController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomInputField(
                  label: 'Description',
                  hintText: 'Description',
                  isPassword: false,
                  controller: _descriptionController,
                  maxLines: 3,
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
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
