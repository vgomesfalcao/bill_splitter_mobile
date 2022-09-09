import 'package:bill_splitter/model/bill/bill.dart';
import 'package:bill_splitter/model/user/userSave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Total')),
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
