import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.maxLines,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    final int? maxLines = widget.isPassword ? 1 : widget.maxLines ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toLowerCase()),
        const SizedBox(height: 8.0),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          keyboardType: widget.keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
