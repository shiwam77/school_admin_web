import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'package:school_admin_web/Screen/CreateHomework/HomeWork.dart';

import '../../Color.dart';
import '../../Responsive.dart';
class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime currentDateTime =DateTime.now();
  List<ClassModel> classList;
  int currentSelectedIndex;
  @override
  Widget build(BuildContext context) {
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
                        currentDateTime = await  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        setState(() {

                        });
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
              Padding(
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
              ),
              Padding(
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
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                        itemBuilder: (context,index){
                      return Container(
                        width: double.infinity,
                        height:  50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1.',style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w300)),
                            Text('Shiwam Karn',style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w300),),
                            SizedBox(width: 20,),
                            CircleAvatar(
                              backgroundColor: Color(0xff39CE15),
                              radius: 15,
                                child: Text('P')),
                            CircleAvatar(
                                backgroundColor: Color(0xffFF3B3B),
                                radius: 15,
                                child: Text('A')),
                            CircleAvatar(
                                backgroundColor: Color(0xff00B9BA),
                                radius: 15,
                                child: Text('L')),
                            CircleAvatar(
                                backgroundColor: Color(0xff6B778D),
                                radius: 15,
                                child: Text('H')),
                          ],
                        )
                      );
                    }),
                  ),
                ),
              )
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
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    return SizedBox(
      height: SizeConfig.hp(5),
      width:SizeConfig.wp(60),
      child: StreamBuilder(
          stream:classProvider.fetchClassAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              classList = snapshot.data.documents.map((e) =>
                  ClassModel.fromMap(e.data, e.documentID))
                  .where((element) => element.academicYearId == academicId.getYearId()).toList();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: classList.length,
                itemBuilder: (context,index){
                  return Consumer<ClassNotifier>(
                    builder: (context,classIdNotify,child){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            currentSelectedIndex = index;
                            classIdNotify.changeSetupClassClassID(classList[index].id);

                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height:SizeConfig.hp(5),
                          alignment: Alignment.center,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:currentSelectedIndex == index ?AppColors.redAccent:AppColors.white,
                          ),
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(classList[index].classes,maxLines: 1,)),
                          ),),
                      );
                    },

                  );
                },
              );
            }
            else{
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height:SizeConfig.hp(7),
                      width:150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(' Loading ',style: TextStyle(color: AppColors.loginBackgroundColor,letterSpacing: .5,fontSize: SizeConfig.textScaleFactor * 10,),),
                          TyperAnimatedTextKit(
                              text: [
                                '.......',
                              ],
                              isRepeatingAnimation: true,
                              speed: Duration(milliseconds: 100),
                              textStyle: TextStyle(
                                  color: AppColors.redAccent,
                                  letterSpacing: 5,fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold
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
