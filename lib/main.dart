import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/subjectCRUD.dart';

import 'Locater.dart';
import 'Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'Screen/AcademicYear/ViewModel/CrudViewModel.dart';
import 'Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'Screen/Login/SignIn.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => academicLocator<AcademicYearViewModel>()),
          ChangeNotifierProvider(create: (_)=> YearNotifier(),),
          ChangeNotifierProvider(create: (_)=> ClassNotifier(),),
          ChangeNotifierProvider(create: (_)=> ClassViewModel()),
          ChangeNotifierProvider(create: (_)=> SubjectViewModel()),
        ],
        child: MaterialApp(home: SignIn()));
  }
}
