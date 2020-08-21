import 'dart:html';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/Attendance/Model/AttendanceModel.dart';
import 'package:school_admin_web/Screen/Attendance/ViewModel/AttendanceCRUD.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'package:school_admin_web/Screen/CreateHomework/HomeWork.dart';

import '../../Color.dart';
import '../../Responsive.dart';
import '../ClassSetup/Model/StudentModel.dart';
import '../ClassSetup/ViewModel/StudentCRUD.dart';
List<AttendanceModel> attendanceList =[];
class Attendances{
  static String present='Present';
  static String absent='Absent';
  static String onLeave='OnLeave';
  static String holiday='Holiday';
  static String none='None';
}
enum AttendanceType{
  Present,Absent,OnLeave,Holiday
}
const presentColor = Color(0xff39CE15);
const absentColor = Color(0xffFF3B3B);
const onLeaveColor = Color(0xff00B9BA);
const holidayColor = Color(0xff6B778D);
const noneColor = AppColors.white;
class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime currentDateTime =DateTime.now();
  List<ClassModel> classList;
  int currentSelectedIndex;

  List<AttendanceModel> snapShotAttendanceList;
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceViewModel>(context,listen: true);
    final studentProvider = Provider.of<StudentViewModel>(context,listen: true);
    final classIdProvider = Provider.of<fetchingClassIDNotifier>(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    return Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffFFFFFF),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff707070).withOpacity(.4),
                    offset: Offset(-8, 3),
                    blurRadius: 12),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 40,top: 20,right: 40,bottom: 10),
                child:screenHeader('Attendance'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(),
                  Text('Please select the class below',
                    maxLines: 2,
                    style: TextStyle(color: AppColors.redAccent,
                        fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: SizeConfig.wp(18),),
                  Tooltip(
                    message: 'Select Date',
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient:LinearGradient(colors: [AppColors.redAccent,AppColors.loginBackgroundColor,]),
                    ),
                    child: InkWell(
                      onTap: () async {
                        try{
                          currentDateTime = await  showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          setState(() {
                          });
                        }
                        catch(ex){
                          print(ex);
                        }

                      },
                      child: Container(
                        width: 75,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff707070).withOpacity(.4),
                                  offset: Offset(1, 1),
                                  blurRadius: 1),
                            ]
                        ),
                        alignment: Alignment.center,
                        child: Text(toHumanReadableDate(currentDateTime),style: TextStyle(
                            color: Color(0xff263859),fontSize: 20,fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.wp(10),),
                ],
              ),
              SizedBox(height: SizeConfig.hp(2),),
              classTile(),
              SizedBox(height: SizeConfig.hp(2),),
              classIdProvider.getClassId() != null? Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(4)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Roll No',style: TextStyle(color: AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold),),
                          Text('Student Name',style: TextStyle(color: AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          SizedBox(width: 50,),
                          Text('Present',style: TextStyle(color:Color(0xff39CE15),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('Absent',style: TextStyle(color: Color(0xffFF3B3B),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('On Leave',style: TextStyle(color: Color(0xff00B9BA),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('Holiday',style: TextStyle(color:Color(0xff6B778D),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                        ],
                      ),

                    ],
                  ),
                ),
              ):SizedBox(),
              classIdProvider.getClassId() != null?Expanded(
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(4)),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                    width: double.infinity,
                    height: SizeConfig.hp(55),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff707070).withOpacity(.4),
                              offset: Offset(0, 0),
                              blurRadius: 10),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                      child: FutureBuilder(
                        future: studentProvider.fetchStudent(),
                        builder: (context,snapShot){
                          List<StudentModel> getStudentList;
                          if(snapShot.hasData){
                            getStudentList = snapShot.data;
                            return StreamBuilder(
                              stream: attendanceProvider.fetchAttendanceAsStream(),
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapShot2){
                                if( attendanceList.length > 0){
                                  attendanceList.clear();
                                }
                                if(snapShot2.hasData){
                                  List<StudentModel> currentStudentList = getStudentList.where((e) => e.academicId == academicId.getYearId()&&
                                      e.classId == classIdProvider.getClassId()).toList();
                                  snapShotAttendanceList = snapShot2.data.documents.map((e) => AttendanceModel.fromMap(e.data, e.documentID)).toList();
                                  currentStudentList.forEach((element) {
                                    AttendanceModel currentAttendance = snapShotAttendanceList.firstWhere((e) => e.classId == element.classId && e.academicId == element.academicId &&
                                        e.studentId == element.id && e.date == toStoreDate(currentDateTime).toString(),orElse: ()=>null);
                                    if(currentAttendance != null){
                                      attendanceList.add(currentAttendance);
                                    }
                                    else{
                                      AttendanceModel noAttendance = AttendanceModel(academicId: element.academicId,classId: element.classId,studentId:element.id,studentName: element.studentName,
                                          date: toStoreDate(currentDateTime).toString(),attendance: Attendances.none.toString(),rollNo: element.rollNo);
                                      attendanceList.add(noAttendance);
                                    }
                                  });
                                  return ListView.builder(
                                      key: GlobalKey(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:attendanceList.length,
                                      itemBuilder: (context,index){
                                        Color present= attendanceList[index].attendance == Attendances.present?presentColor:noneColor;
                                        Color absent =attendanceList[index].attendance == Attendances.absent?absentColor:noneColor;
                                        Color onLeave = attendanceList[index].attendance == Attendances.onLeave?onLeaveColor:noneColor;
                                        Color holiday = attendanceList[index].attendance == Attendances.holiday?holidayColor:noneColor;
                                        return
                                          DoAttendance(key: GlobalKey(),attendance: attendanceList[index],presentColor: present,absentColor: absent,
                                            onHolidayColor: holiday,onLeaveColor: onLeave,index: index,);
                                      });
                                }
                                else{
                                  return SizedBox();
                                }
                              },
                            );
                          }
                          else{
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                ) ,
              ):SizedBox(),
              classIdProvider.getClassId() != null?Padding(
                padding:  EdgeInsets.only(right:SizeConfig.wp(8),bottom: 20 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [MaterialButton(
                    color:AppColors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: AppColors.white,fontSize: SizeConfig.textScaleFactor * 15),
                    ),
                    onPressed: () {
                      attendanceList.forEach((e) {
                        final attendanceProvider = Provider.of<AttendanceViewModel>(context,listen: false);
                         var checkedAttendance = snapShotAttendanceList.firstWhere((element) => element.academicId == e.academicId && e.studentId == e.studentId && element.id == e.id && e.date == element.date,orElse:() =>null);
                         if(checkedAttendance == null){
                           print('true');
                           attendanceProvider.addAttendance(e);
                         }
                         else{
                           print('false');
                           attendanceProvider.updateAttendance(e, e.id);
                         }
                      });
                    },
                  )],),
              ):SizedBox(),
            ],
          ),
        ));
  }

  Widget screenHeader(String tittle){
    return  Row(
      children: [
        Text(
          tittle,
          style: TextStyle(
              color: Color(0xff263859),
              fontSize: SizeConfig.textScaleFactor * 30,
              letterSpacing: 1,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Divider(
              thickness: .5,
              color: Color(0xff6B778D).withOpacity(.5),
            ),
          ),
        )
      ],
    );
  }
  Widget classTile(){
    final classProvider = Provider.of<ClassViewModel >(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    return SizedBox(
      height: SizeConfig.hp(5),
      width:SizeConfig.wp(60),
      child: FutureBuilder(
          future:classProvider.fetchClass(),
          builder: (context, snapshot) {
            List<ClassModel> getClassList;
            if (snapshot.hasData) {
              getClassList = snapshot.data;
              classList =
                  getClassList.where((element) => element.academicYearId ==
                      academicId.getYearId()).toList();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: classList.length,
                itemBuilder: (context, index) {
                  return Consumer<fetchingClassIDNotifier>(
                    builder: (context, classIdNotify, child) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedIndex = index;
                            classIdNotify.changeClassClassID(
                                classList[index].id);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: SizeConfig.hp(5),
                          alignment: Alignment.center,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: currentSelectedIndex == index ? AppColors
                                .redAccent : AppColors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  classList[index].classes, maxLines: 1,)),
                          ),),
                      );
                    },

                  );
                },
              );
            }
            else if (snapshot.hasData == null) {
              return Text('null');
            }
            else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: SizeConfig.hp(7),
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(' Loading ', style: TextStyle(
                            color: AppColors.loginBackgroundColor,
                            letterSpacing: .5,
                            fontSize: SizeConfig.textScaleFactor * 10,),),
                          TyperAnimatedTextKit(
                              text: [
                                '.......',
                              ],
                              isRepeatingAnimation: true,
                              speed: Duration(milliseconds: 100),
                              textStyle: TextStyle(
                                  color: AppColors.redAccent,
                                  letterSpacing: 5,
                                  fontSize: SizeConfig.textScaleFactor * 30,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional.topStart
                          )
                        ],
                      )),
                ],
              );
            }
          }
      ),
    );
  }
}
String toStoreDate(DateTime timestamp) {
  var moonLanding = timestamp;
  var jiffy = Jiffy([
    moonLanding.year,
    moonLanding.month,
    moonLanding.day,
    moonLanding.hour,
    moonLanding.minute,
    00,
  ]).format("dd,MMM yyy");
  return jiffy;
}
class DoAttendance extends StatefulWidget {
  //final context;
  final AttendanceModel attendance;
   final int index;
  final Color presentColor;
  final Color absentColor;
  final Color onHolidayColor;
  final Color onLeaveColor;
  DoAttendance({Key key,this.attendance,this.presentColor,this.onLeaveColor,this.absentColor,this.onHolidayColor,this.index}):super(key: key);
  @override
  _DoAttendanceState createState() => _DoAttendanceState();
}

class _DoAttendanceState extends State<DoAttendance> {
  Color presentCheck = noneColor;
  Color absentCheck  = noneColor;
  Color onLeaveCheck = noneColor;
  Color holidayCheck = noneColor;
  bool present,absent,onHoliday,onLeave = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      presentCheck = widget.presentColor;
      absentCheck = widget.absentColor;
      onLeaveCheck = widget.onLeaveColor;
      holidayCheck = widget.onHolidayColor;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      key:  GlobalKey(),
        width: double.infinity,
        height:  50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 450,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                Text('${widget.attendance.rollNo}.',style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w500)),
                  SizedBox(width: 70,),
                Text(widget.attendance.studentName,style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w700),),
           ],),
            ),
            Container(
              width: 450,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(
                  onTap: (){
                    // update(AttendanceType.Present);
                    setState(() {
                      update(AttendanceType.Present);
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: presentCheck,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,0),
                              blurRadius: 6
                          ),
                        ]
                    ),
                    alignment: Alignment.center,
                    child: Text('P',style: TextStyle(color: presentCheck == presentColor?AppColors.white:presentColor),),
                  ),
                ),
                  SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    setState(() {
                      update(AttendanceType.Absent);
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: absentCheck,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,0),
                              blurRadius: 6
                          ),
                        ]
                    ),
                    alignment: Alignment.center,
                    child: Text('A',style: TextStyle(color: absentCheck == absentColor?AppColors.white:absentColor)),
                  ),
                ),
                  SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    setState(() {
                      update(AttendanceType.OnLeave);
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: onLeaveCheck,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,0),
                              blurRadius: 6
                          ),
                        ]
                    ),
                    alignment: Alignment.center,
                    child: Text('L',style: TextStyle(color: onLeaveCheck == onLeaveColor?AppColors.white:onLeaveColor)),
                  ),
                ),
                  SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    setState(() {
                      update(AttendanceType.Holiday);
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: holidayCheck,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,0),
                              blurRadius: 6
                          ),
                        ]
                    ),
                    alignment: Alignment.center,
                    child: Text('H',style: TextStyle(color: holidayCheck == holidayColor?AppColors.white:holidayColor)),
                  ),
                ),
              ],),
            ),
          ],
        )
    );
  }
  update(AttendanceType attendanceType){
    if(attendanceType == AttendanceType.Present){
      if(presentCheck == presentColor){
        presentCheck = noneColor;
        widget.attendance.attendance = Attendances.none;
      }
      else{
        presentCheck = presentColor;
        widget.attendance.attendance = Attendances.present;
        absentCheck = noneColor;
        onLeaveCheck = noneColor;
        holidayCheck = noneColor;
      }
      attendanceList.removeAt(widget.index);
      attendanceList.insert(widget.index, widget.attendance);
    }
    else if(attendanceType == AttendanceType.Absent){
      if(absentCheck == absentColor){
        absentCheck = noneColor;
        widget.attendance.attendance = Attendances.none;
      }
      else{
        presentCheck = noneColor;
        absentCheck = absentColor;
        widget.attendance.attendance = Attendances.absent;
        onLeaveCheck = noneColor;
        holidayCheck = noneColor;
      }
      attendanceList.removeAt(widget.index);
      attendanceList.insert(widget.index, widget.attendance);
    }
    else if(attendanceType == AttendanceType.OnLeave){
      if(onLeaveCheck == onLeaveColor){
        onLeaveCheck = noneColor;
        widget.attendance.attendance = Attendances.none;
      }
      else{
        presentCheck = noneColor;
        absentCheck = noneColor;
        onLeaveCheck = onLeaveColor;
        widget.attendance.attendance = Attendances.onLeave;
        holidayCheck = noneColor;
      }
      attendanceList.removeAt(widget.index);
      attendanceList.insert(widget.index, widget.attendance);
    }

    else if(attendanceType == AttendanceType.Holiday){
      if(holidayCheck == holidayColor){
        holidayCheck = noneColor;
        widget.attendance.attendance = Attendances.none;
      }
      else{
        presentCheck = noneColor;
        absentCheck = noneColor;
        onLeaveCheck = noneColor;
        holidayCheck = holidayColor;
        widget.attendance.attendance = Attendances.holiday;
      }
      attendanceList.removeAt(widget.index);
      attendanceList.insert(widget.index, widget.attendance);
    }
  }
}
