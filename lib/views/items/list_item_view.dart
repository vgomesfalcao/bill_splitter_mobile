import 'package:bill_splitter/model/bill/item_model.dart';
import 'package:bill_splitter/model/user/user_save_model.dart';
import 'package:bill_splitter/views/items/formulario_item_view.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final List<BillItem> _items = [];
  ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final String _itemListTitle = 'Itens';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_itemListTitle),
      ),
      body: ListView.builder(
          itemCount: widget._items.length,
          itemBuilder: (context, index) {
            return ItemItem(widget._items[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (UserSave().getUsers().length >= 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ItemRegisterForm();
            })).then((receivedItem) => _update(receivedItem));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Necessário pelo menos duas pessoas cadastradas'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _update(BillItem receivedItem) {
    setState(() {
      widget._items.add(receivedItem);
    });
  }
}

class ItemItem extends StatelessWidget {
  final BillItem _item;

  const ItemItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on_outlined),
      title: Text(_item.itemLabel),
      subtitle: Text(
          'R\$ ${_item.itemValue.toStringAsFixed(2).replaceAll('.', ',')}'),
    ));
  }
}