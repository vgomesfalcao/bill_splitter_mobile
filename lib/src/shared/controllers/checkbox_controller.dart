class CheckboxController {
  bool _isChecked = false;

  void switchCheck() {
    _isChecked = !_isChecked;
  }

  bool getValue() {
    return _isChecked;
  }
}
