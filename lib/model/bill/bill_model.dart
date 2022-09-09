import 'package:bill_splitter/model/bill/item_model.dart';
import 'package:bill_splitter/model/user/user_model.dart';

class Bill {
  static final List<BillItem> _billItemList = [];

  String getTotalBill() {
    double totalValue = 0.0;
    for (var item in _billItemList) {
      totalValue += item.itemValue;
    }
    return totalValue.toStringAsFixed(2);
  }

  String getUserBill(String userName) {
    double totalValue = 0;
    for (var item in _billItemList) {
      for (var user in item.users) {
        user.name == userName
            ? totalValue += item.itemValue / item.users.length
            : null;
      }
    }
    return totalValue.toStringAsFixed(2);
  }

  List<BillItem> getBillList() {
    return _billItemList;
  }

  void addBillItem(String label, double value, List<User> users) {
    Bill._billItemList.add(BillItem(label, value, users));
  }
}
