import 'package:flutter/material.dart';

class ClassNotifier extends ChangeNotifier{
  String _classId;
  getClassId() => _classId;
  void changeClassClassID(String classId) async {
    _classId = classId;
    notifyListeners();
  }
}

class fetchingClassIDNotifier extends ChangeNotifier{
  String _classId;
  getClassId() => _classId;
  void changeClassClassID(String classId) async {
    _classId = classId;
    notifyListeners();
  }
}

class AttendanceClassIDNotifier extends ChangeNotifier{
  String _classId;
  getClassId() => _classId;
  void changeClassClassID(String classId) async {
    _classId = classId;
    notifyListeners();
  }
}