import 'package:bill_splitter/src/models/person/person_model.dart';

class PersonListModel {
  static final List<Person> _userList = [];

  void addUser(Person user) {
    PersonListModel._userList.add(user);
  }

  List<Person> getUsers() {
    List<Person> list = [..._userList];
    return list;
  }
}
