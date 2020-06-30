import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _currentPage = 0;

  set currentPage(value) {
    _currentPage = value;
    notifyListeners();
  }

  get currentPage => _currentPage;
}
