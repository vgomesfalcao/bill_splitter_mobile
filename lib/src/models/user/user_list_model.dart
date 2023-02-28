import 'package:bill_splitter/src/models/user/user_model.dart';

class UserListModel {
  static final List<User> _userList = [];

  void addUser(User user) {
    UserListModel._userList.add(user);
  }

  List<User> getUsers() {
    List<User> list = [..._userList];
    return list;
  }
}
