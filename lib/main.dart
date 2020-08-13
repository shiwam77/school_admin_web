
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/subjectCRUD.dart';

import 'Locater.dart';
import 'Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'Screen/AcademicYear/ViewModel/CrudViewModel.dart';
import 'Screen/Attendance/ViewModel/AttendanceCRUD.dart';
import 'Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'Screen/ClassSetup/ViewModel/StudentCRUD.dart';
import 'Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'Screen/CreateHomework/ViewModel/HomeworkCRUD.dart';
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
          ChangeNotifierProvider(create: (_)=> fetchingClassIDNotifier(),),
          ChangeNotifierProvider(create: (_)=> AttendanceClassIDNotifier(),),
          ChangeNotifierProvider(create: (_)=> ClassViewModel()),
          ChangeNotifierProvider(create: (_)=> SubjectViewModel()),
          ChangeNotifierProvider(create: (_)=>StudentViewModel(),),
          ChangeNotifierProvider(create: (_)=>HomeWorkViewModel(),),
          ChangeNotifierProvider(create: (_)=> AttendanceViewModel(),),
        ],
        child: MaterialApp(home: SignIn()));
  }
}
