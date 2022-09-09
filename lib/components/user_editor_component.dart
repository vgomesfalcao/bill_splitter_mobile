import 'package:flutter/material.dart';

class UserEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const UserEditor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
