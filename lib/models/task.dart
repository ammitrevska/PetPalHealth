import 'package:petpal_health/models/category.dart';

class Task {
  final String name;
  final Category category;
  final int repetition;

  Task({
    required this.name,
    required this.category,
    required this.repetition,
  });
}
