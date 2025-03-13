import 'package:flutter/material.dart';

Widget customIcon(IconData outlinedIcon, IconData filledIcon,
    {double size = 36.0, bool isSelected = false}) {
  return Icon(
    isSelected ? filledIcon : outlinedIcon,
    size: size,
    color: isSelected
        ? const Color(0xFFFEA549)
        : const Color.fromARGB(212, 0, 0, 0),
  );
}
