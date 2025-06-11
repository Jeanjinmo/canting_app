import 'package:flutter/material.dart';

class LoginTabProvider extends ChangeNotifier {
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void setCurrentTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  // bool get isLoginTab => _currentTabIndex == 0;
  // bool get isPhoneTab => _currentTabIndex == 1;

  // String get currentTabName => _currentTabIndex == 0 ? 'Login' : 'Phone Number';
}
