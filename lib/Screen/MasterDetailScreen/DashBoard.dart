import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/Attendance/Attendance.dart';
import 'package:school_admin_web/Screen/ClassSetup/ManageClass.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'package:school_admin_web/Screen/CreateHomework/HomeWork.dart';
import 'package:school_admin_web/Screen/ExamSchedule/ExamSchedule.dart';
import 'package:school_admin_web/Screen/Home/Home.dart';
import 'package:school_admin_web/Screen/NewStudent/NewStudent.dart';
import 'package:school_admin_web/Screen/Notification/Notification.dart';
import 'package:school_admin_web/Screen/TimeTable/TimeTable.dart';
import 'package:school_admin_web/Screen/Tutor/Tutor.dart';


import '../../Color.dart';
import '../../Image.dart';
import '../../Responsive.dart';

import '../../loadingPage.dart';
import 'Masterpage.dart';
import 'NavModel_vm.dart';





class DashBoard extends StatefulWidget {
  final academicYear;
  DashBoard({this.academicYear});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget screen = Home();
  @override
  Widget build(BuildContext context) {
    final academicIdProvider  = Provider.of<YearNotifier>(context,listen: true);
    final classProvider = Provider.of<ClassViewModel>(context,listen: true);
    return MultiProvider(
      providers: [
         ChangeNotifierProvider<NavIndex>(create: (context) => NavIndex()),

      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: AppColors.loginBackgroundColor,
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.backgroundShape,
                      fit: BoxFit.fill,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10,right: SizeConfig.wp(2),bottom:SizeConfig.hp(2.5)),
                        child: Image.asset(
                          AppImages.homePanelLogo,
                          height: SizeConfig.hp(4),
                          width: 250,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 45,
                bottom: 45,
                left: 25,
                right: 25,
                child: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff263859),
                  ),
                  child: Row(
                    children: [
                      MasterPage(),
                      Consumer<NavIndex>(
                        builder: (context,navIndex,child){
                          print(navIndex.getCounter());
                          if (navIndex.getCounter() == 0) {
                            screen = Home();
                          } else if (navIndex.getCounter() == 1) {
                            screen = ManageClass();
                          } else if (navIndex.getCounter() == 2) {
                            screen = FutureBuilder(
                            future:classProvider.fetchClass(),
                            builder: (context, AsyncSnapshot snapshot){
                              if(snapshot.hasData){
                                List<ClassModel> classes;
                                List<ClassModel> classList = List();
                                classes = snapshot.data;
                                classList = classes.where((element) => element.academicYearId == academicIdProvider.getYearId()).toList();
                                if(classList.length ==0){
                                  return LoadingPage();
                                }
                                return NewStudent(classList: classList,);
                              }
                              return LoadingPage();
                            });
                          } else if (navIndex.getCounter() == 3) {
                            screen = HomeWork();
                          } else if (navIndex.getCounter() == 4) {
                            screen = Attendance();
                          } else if (navIndex.getCounter() == 5) {
                            screen = ExamSchedule();
                          }
                          else if (navIndex.getCounter() == 6) {
                            screen = TimeTable();
                          }
                          else if (navIndex.getCounter() == 7) {
                            screen = Tutor();
                          }
                          else if (navIndex.getCounter() == 8) {
                            screen = CreateNotification();
                          }
                          return screen;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
