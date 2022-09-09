import 'package:bill_splitter/model/user/user.dart';

class BillItem {
  final String itemLabel;
  final double itemValue;
  final List<User> users;

  BillItem(this.itemLabel, this.itemValue, this.users);

  @override
  String toString() {
    return 'Novo item adicionado com os usuários $users';
  }
}
