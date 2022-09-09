import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemEditor extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textFormatters;

  const ItemEditor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.textFormatters,
  });

  @override
  State<StatefulWidget> createState() => _ItemEditorState();
}

class _ItemEditorState extends State<ItemEditor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.textFormatters,
      ),
    );
  }
}
