import 'package:bill_splitter/model/bill/item.dart';
import 'package:bill_splitter/model/user.dart';

class Bill {
  final List<BillItem> billItemList = [];

  String getTotalBill() {
    double totalValue = 0.0;
    for (var item in billItemList) {
      totalValue += item.itemValue;
    }
    return totalValue.toStringAsFixed(2);
  }

  String getUserBill(String userName) {
    double totalValue = 0;
    for (var item in billItemList) {
      for (var element in item.users) {
        element.name == userName ? totalValue += item.itemValue : null;
      }
    }
    return totalValue.toStringAsFixed(2);
  }

  void addBillItem(String label, double value, List<User> users) {
    billItemList.add(BillItem(label, value, users));
  }
}
