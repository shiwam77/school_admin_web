import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearNotifier extends ChangeNotifier{
  String _yearId;

  getYearId() => _yearId;

  void changeYearId(String yearId) async {
    _yearId = yearId;
    notifyListeners();
  }

}