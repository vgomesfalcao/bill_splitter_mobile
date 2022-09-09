import 'package:bill_splitter/model/user/user_model.dart';

class UserSave {
  static final List<User> _userList = [];

  void addUser(User user) {
    UserSave._userList.add(user);
  }

  List<User> getUsers() {
    List<User> list = [..._userList];
    return list;
  }
}
