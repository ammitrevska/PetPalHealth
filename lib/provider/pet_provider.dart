import 'package:flutter/material.dart';
import 'package:petpal_health/models/pet.dart';

class PetProvider extends ChangeNotifier {
  Pet? _pet;

  Pet? get pet => _pet;

  void setPet(Pet pet) {
    _pet = pet;
    notifyListeners();
  }
}
