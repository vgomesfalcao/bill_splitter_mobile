import 'package:bill_splitter/components/userEditor.dart';
import 'package:bill_splitter/model/user/user.dart';
import 'package:bill_splitter/model/user/userSave.dart';
import 'package:flutter/material.dart';

class UserRegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserRegisterFormState();
  }
}

class UserRegisterFormState extends State<UserRegisterForm> {
  final TextEditingController _nameFieldController = TextEditingController();
  final String _registerPageTitle = 'Cadastro';
  final String _labelFieldName = 'Nome';
  final String _hintFieldName = 'Fulano da silva sauro';
  final String _buttonFieldName = 'Confirmar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_registerPageTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserEditor(
              controller: _nameFieldController,
              label: _labelFieldName,
              hint: _hintFieldName,
            ),
            ElevatedButton(
              onPressed: () {
                final String userName = _nameFieldController.text;
                if (userName != '') {
                  final createdUser = User(userName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$createdUser'),
                    ),
                  );
                  Navigator.pop(
                    context,
                    createdUser,
                  );
                }
              },
              child: Text(_buttonFieldName),
            )
          ],
        ),
      ),
    );
  }
}
