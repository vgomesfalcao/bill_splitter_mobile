import 'package:bill_splitter/model/user.dart';
import 'package:bill_splitter/screens/user/formulario.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  final List<User> _users = [];

  UserList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  final String _appbarUsersTitle = 'Usuários';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appbarUsersTitle),
      ),
      body: ListView.builder(
          itemCount: widget._users.length,
          itemBuilder: (context, index) {
            return UserItem(widget._users[index]);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserRegisterForm();
          })).then((receivedUser) => _update(receivedUser));
        },
      ),
    );
  }

  void _update(User receivedUser) {
    setState(() {
      widget._users.add(receivedUser);
    });
  }
}

class UserItem extends StatelessWidget {
  final User _user;

  const UserItem(this._user);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.people),
      title: Text(_user.name),
    ));
  }
}
