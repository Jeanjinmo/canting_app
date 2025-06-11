import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavBar => _indexBottomNavBar;

  void updateIndexBottomNavBar(int index) {
    if (_indexBottomNavBar != index) {
      _indexBottomNavBar = index;
    }
    notifyListeners();
  }

  void resetIndex() {
    _indexBottomNavBar = 0;
    notifyListeners();
  }
}
