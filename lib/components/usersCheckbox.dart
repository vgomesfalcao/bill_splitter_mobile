import 'package:bill_splitter/controller/checkboxController.dart';
import 'package:flutter/material.dart';

class UsersCheckbox extends StatefulWidget {
  final String name;
  final CheckboxController checkboxController;
  const UsersCheckbox(
      {Key? key, required this.name, required this.checkboxController})
      : super(key: key);

  @override
  State<UsersCheckbox> createState() =>
      _UsersCheckboxState(checkboxController: checkboxController);
}

class _UsersCheckboxState extends State<UsersCheckbox> {
  CheckboxController checkboxController;
  _UsersCheckboxState({required this.checkboxController});
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: const Icon(Icons.people),
      title: Text(widget.name),
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: checkboxController.getValue(),
      onChanged: (bool? value) {
        setState(() {
          checkboxController.switchCheck();
        });
      },
    );
  }
}
