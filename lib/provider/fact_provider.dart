import 'package:flutter/material.dart';
import 'package:petpal_health/services/api_service.dart';
import '../models/facts.dart';

class FactProvider with ChangeNotifier {
  final ApiService apiService;

  List<Facts> dogFacts = [];
  List<Facts> catFacts = [];
  bool isLoading = false;
  String errorMessage = '';

  FactProvider({required this.apiService});

  // Fetch dog facts
  Future<void> fetchDogFacts() async {
    isLoading = true;
    notifyListeners();
    try {
      dogFacts = await apiService.fetchDogFacts();
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Error: $e';
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch cat facts
  Future<void> fetchCatFacts() async {
    isLoading = true;
    notifyListeners();
    try {
      catFacts = await apiService.fetchCatFacts();
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Error: $e';
    }
    isLoading = false;
    notifyListeners();
  }
}
