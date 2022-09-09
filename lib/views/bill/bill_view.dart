import 'package:bill_splitter/controller/form_item_controller.dart';
import 'package:bill_splitter/model/user/user_list_model.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final FormItemController _formItemController = FormItemController();
  bool withTip = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total')),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title:
                Text.rich(TextSpan(style: TextStyle(fontSize: 20), children: [
              TextSpan(text: 'Total: '),
              TextSpan(
                  text: 'R\$ ${_formItemController.getTotalBill()}',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ])),
          ),
          height: 60,
        ),
        shape: const CircularNotchedRectangle(),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: UserListModel().getUsers().length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Center(
                          widthFactor: 0.6,
                          child:
                              Icon(Icons.monetization_on_outlined, size: 60)),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0),
                        child: Text(
                          UserListModel().getUsers()[index].name,
                        ),
                      ),
                      subtitle:
                          _formItemController.getValueFromUserIndex(index),
                      isThreeLine: true,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: SwitchListTile(
                title: Text('Adicionar 10 %'),
                value: _formItemController.getTip(),
                onChanged: (bool value) {
                  setState(() => _formItemController.changeTip());
                }),
          )
        ],
      ),
    );
  }
}
