import 'package:bill_splitter/src/components/user_editor_component.dart';
import 'package:bill_splitter/src/model/user/user_model.dart';
import 'package:flutter/material.dart';

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({Key? key}) : super(key: key);

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
