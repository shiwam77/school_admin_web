import 'package:flutter/material.dart';

class ClassNotifier extends ChangeNotifier{
  String _classId;
  String classesId;
  getClassSetupClassId() => _classId;

  String _homeTaskClassId;
  String homeTaskClassId;
  getHomeTaskClassId() => _homeTaskClassId;

  void changeSetupClassClassID(String classId) async {
    _classId = classId;
    classesId = classId;
    notifyListeners();
  }
  void changeHomeTaskClassID(String homeTaskClassId) async {
    _homeTaskClassId = homeTaskClassId;
    classesId = homeTaskClassId;
    notifyListeners();
  }
  void changeAttendanceClassID(String classId) async {
    _classId = classId;
    classesId = classId;
    notifyListeners();
  }
}