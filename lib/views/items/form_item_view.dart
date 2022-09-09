import 'package:bill_splitter/components/item_editor_component.dart';
import 'package:bill_splitter/components/users_checkbox_component.dart';
import 'package:bill_splitter/controller/bill_controller.dart';
import 'package:bill_splitter/controller/checkbox_controller.dart';
import 'package:bill_splitter/model/bill/item_model.dart';
import 'package:bill_splitter/model/user/user_model.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemRegisterForm extends StatefulWidget {
  const ItemRegisterForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ItemRegisterFormState();
  }
}

class ItemRegisterFormState extends State<ItemRegisterForm> {
  final TextEditingController _descriptionFieldController =
      TextEditingController();
  final TextEditingController _valueFieldController = TextEditingController();
  final String _registerPageTitle = 'Novo item';
  final String _labelFieldDescription = 'Descrição';
  final String _hintFieldDescription = 'Item';
  final String _buttonFieldName = 'Confirmar';
  final String _labelFieldValue = 'Valor';
  final String _hintFieldValue = 'R\$ 0.00';
  final Map<String, dynamic> _states = {};
  final List<User> _users = UserListModel().getUsers();

  static const _locale = 'pt_BR';
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_registerPageTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ItemEditor(
              controller: _descriptionFieldController,
              label: _labelFieldDescription,
              hint: _hintFieldDescription,
            ),
            ItemEditor(
              controller: _valueFieldController,
              label: _labelFieldValue,
              hint: _hintFieldValue,
              keyboardType: TextInputType.number,
              textFormatters: [
                CurrencyTextInputFormatter(
                  symbol: _currency,
                  decimalDigits: 2,
                  locale: 'pt_br',
                )
              ],
            ),
            ..._createCheckboxList(),
            ElevatedButton(
              onPressed: () {
                final String itemLabel = _descriptionFieldController.text;
                final double? itemValue = _convertItemValue();
                if (_getUserList().isNotEmpty) {
                  final createdBill =
                      BillItem(itemLabel, itemValue!, _getUserList());
                  BillController.instance.updateValues();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$createdBill'),
                    ),
                  );
                  Navigator.pop(
                    context,
                    createdBill,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selecione no mínimo uma pessoa'),
                    ),
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

  List<Widget> _createCheckboxList() {
    Map<String, dynamic> states = _getStates();

    List<UsersCheckbox> checkboxes = [];
    for (var user in _users) {
      checkboxes.add(UsersCheckbox(
        name: states[user.name]['name'],
        checkboxController: states[user.name]['controller'],
      ));
    }
    return checkboxes;
  }

  Map<String, dynamic> _getStates() {
    for (var user in _users) {
      _states[user.name] = {
        'name': user.name,
        'controller': CheckboxController(),
        'object': user
      };
    }
    return _states;
  }

  List<User> _getUserList() {
    final List<User> selectedUsers = [];
    for (var user in _users) {
      if (_states[user.name]['controller'].getValue()) {
        selectedUsers.add(_states[user.name]['object']);
      }
    }
    return selectedUsers;
  }

  double? _convertItemValue() {
    double? parsedItem = double.tryParse(
      _valueFieldController.text.replaceAll(RegExp(r"\D"), ""),
    );
    return parsedItem! / 100;
  }
}
