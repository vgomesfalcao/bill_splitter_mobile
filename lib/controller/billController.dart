import 'package:flutter/material.dart';

class BillController extends ChangeNotifier {
  static BillController instance = BillController();

  void updateValues() {
    notifyListeners();
  }
}
