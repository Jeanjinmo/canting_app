import 'package:flutter/material.dart';

class SimplePropertyProvider extends ChangeNotifier {
  bool _isHidden = true;
  bool _isExpanded = false;

  bool get isHidden => _isHidden;
  bool get isExpanded => _isExpanded;

  void toggleHidden() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
