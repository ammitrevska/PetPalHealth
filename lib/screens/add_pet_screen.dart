import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:petpal_health/constants.dart';
import 'package:petpal_health/models/pet.dart';
import 'package:petpal_health/provider/pet_provider.dart';
import 'package:petpal_health/widgets/custom_input_field.dart';
import 'package:petpal_health/widgets/gradient_background.dart';
import 'package:provider/provider.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  String calculateAge(DateTime dob) {
    final today = DateTime.now();
    int years = today.year - dob.year;
    int months = today.month - dob.month;

    if (months < 0) {
      years--;
      months += 12;
    }

    if (years == 0) {
      return '$months months';
    }

    if (months == 0) {
      return '$years years';
    }

    return '$years years, $months months';
  }

  String? _selectedPet;
  String? _selectedGender;
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  Widget _buildRadioButtons({
    required List<String> options,
    String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: options.map((option) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: option,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
            Text(option),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add a pet'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          onPressed: () {
                            _pickImage();
                            Navigator.pop(context);
                          },
                          child: const Text('Gallery'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            _takePicture();
                            Navigator.pop(context);
                          },
                          child: const Text('Camera'),
                        ),
                      ],
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      _image != null ? FileImage(File(_image!.path)) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt,
                          size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomInputField(
                hintText: 'Name of the pet',
                label: 'Pet\'s name',
                isPassword: false,
                controller: _nameController,
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Species'),
                  _buildRadioButtons(
                    options: [
                      'Cat',
                      'Dog',
                      'Rabbit',
                      'Parrot',
                    ],
                    selectedValue: _selectedPet,
                    onChanged: (value) {
                      setState(() {
                        _selectedPet = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                hintText: 'Breed',
                label: 'Breed',
                isPassword: false,
                controller: _breedController,
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Gender'),
                  _buildRadioButtons(
                    options: ['Male', 'Female'],
                    selectedValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
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
                          _ageController.text =
                              '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomInputField(
                          hintText: 'Date of birth',
                          label: 'Date of birth',
                          isPassword: false,
                          controller: _ageController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Flexible(
                    fit: FlexFit.loose,
                    child: CustomInputField(
                      hintText: 'Weight',
                      label: 'Weight',
                      isPassword: false,
                      controller: _weightController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 56.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    final inputDate = DateTime.tryParse(_ageController.text);
                    if (inputDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid date of birth')),
                      );
                      return;
                    }
                    final pet = Pet(
                      name: _nameController.text,
                      profileImage: _image?.path ?? '',
                      species: _selectedPet ?? '',
                      breed: _breedController.text,
                      gender: _selectedGender ?? '',
                      weight: double.tryParse(_weightController.text) ?? 0.0,
                      age: calculateAge(inputDate),
                    );
                    Provider.of<PetProvider>(context, listen: false)
                        .setPet(pet);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kButtonColor,
                    foregroundColor: kTextColor,
                  ),
                  child: const Text(
                    'Save Pet',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
