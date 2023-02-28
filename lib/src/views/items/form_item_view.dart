import 'package:bill_splitter/src/shared/components/item_editor_component.dart';
import 'package:bill_splitter/src/shared/components/users_checkbox_component.dart';
import 'package:bill_splitter/src/controllers/form_item_controller.dart';
import 'package:bill_splitter/src/models/bill/item_model.dart';
import 'package:bill_splitter/src/models/user/user_model.dart';
import 'package:bill_splitter/src/models/user/user_list_model.dart';
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
  final FormItemController _formItemcontroller = FormItemController();

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
                final double? itemValue = _formItemcontroller
                    .convertNumberStringToValue(_valueFieldController.text);
                if (_formItemcontroller.getUserList().isNotEmpty) {
                  final createdBill = BillItem(
                      itemLabel, itemValue!, _formItemcontroller.getUserList());
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
    Map<String, dynamic> states = _formItemcontroller.getStates();

    List<UsersCheckbox> checkboxes = [];
    for (var user in _users) {
      checkboxes.add(UsersCheckbox(
        name: states[user.name]['name'],
        checkboxController: states[user.name]['controller'],
      ));
    }
    return checkboxes;
  }
}
