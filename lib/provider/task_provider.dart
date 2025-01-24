import 'package:flutter/material.dart';
import 'package:petpal_health/models/task.dart';

class TaskProvider extends ChangeNotifier {
  Task? _task;

  Task? get task => _task;

  void setPet(Task pet) {
    _task = task;
    notifyListeners();
  }
}
