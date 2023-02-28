import 'package:bill_splitter/src/views/bill/bill_view.dart';
import 'package:bill_splitter/src/views/items/list_item_view.dart';
import 'package:bill_splitter/src/views/user/list_user_view.dart';
import 'package:flutter/material.dart';

class BillNavigationBar extends StatefulWidget {
  const BillNavigationBar({Key? key}) : super(key: key);

  @override
  State<BillNavigationBar> createState() => _BillNavigationBarState();
}

class _BillNavigationBarState extends State<BillNavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const UserList(),
    const ItemList(),
    const BillScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pessoas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Itens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Conta',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
