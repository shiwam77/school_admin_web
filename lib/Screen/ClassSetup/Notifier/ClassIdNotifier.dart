import 'package:flutter/material.dart';

class ClassNotifier extends ChangeNotifier{
  String _classId;
  String classesId;
  getClassId() => _classId;

  void changeClassID(String classId) async {
    _classId = classId;
    classesId = classId;
    notifyListeners();
  }

}