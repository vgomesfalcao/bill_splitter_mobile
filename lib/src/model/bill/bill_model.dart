import 'package:bill_splitter/src/model/bill/item_model.dart';

class Bill {
  static final List<BillItem> _billItemList = [];

  List<BillItem> getBillList() {
    return _billItemList;
  }

  void addBillItem(BillItem billItem) {
    Bill._billItemList.add(billItem);
  }
}
