import 'package:bill_splitter/model/bill/bill_model.dart';
import 'package:bill_splitter/model/user/user_save_model.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total')),
      body: ListView.builder(
          itemCount: UserSave().getUsers().length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const Center(
                    widthFactor: 0.6,
                    child: Icon(Icons.monetization_on_outlined, size: 60)),
                title: Text(UserSave().getUsers()[index].name),
                subtitle: Text(
                  'R\$ ${Bill().getUserBill(UserSave().getUsers()[index].name)}',
                ),
                isThreeLine: true,
              ),
            );
          }),
    );
  }
}
