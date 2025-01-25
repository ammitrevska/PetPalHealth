import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.description,
  });
}
