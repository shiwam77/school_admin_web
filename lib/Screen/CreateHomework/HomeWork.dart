
import 'dart:html';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/SubjectModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/subjectCRUD.dart';
import 'package:intl/intl.dart';
import 'package:school_admin_web/Screen/CreateHomework/Model/homeworkModel.dart';
import 'package:school_admin_web/Screen/CreateHomework/ViewModel/HomeworkCRUD.dart';
import '../../Color.dart';
import '../../Responsive.dart';

class HomeWork extends StatefulWidget {
  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  List<SubjectModel> subjectList;
  List<ClassModel> classList;
  int currentSelectedIndex;
  List<HomeworkModel> homeworkList =[];
  DateTime currentDateTime =DateTime.now();
  File file;
  @override
  Widget build(BuildContext context) {
    setState(() {
      file = null;
    });
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    return Expanded(child: Container(
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
            child:screenHeader('Home Task'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          classIdProvider.getClassId() != null?
          subjectTileWithHomework():SizedBox(),
        ],
      ),
    ));
  }
  Widget subjectTileWithHomework(){
    final homeworkProvider = Provider.of<HomeWorkViewModel>(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    final subjectProvider = Provider.of<SubjectViewModel >(context,listen: true);
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(10),vertical: 10),
      child: Container(
        width: double.infinity,
        height: SizeConfig.blockSizeVertical * 65,
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: subjectProvider.fetchClass(),
          builder: (context,snapshot){
            List<HomeworkModel> homework = [];
            List<SubjectModel> subjects;
            if(snapshot.hasData){
              subjects = snapshot.data;
              subjectList =subjects;
              return FutureBuilder(
                future:homeworkProvider.fetchHomework(),
                builder: (context,snapshot2){
                  homeworkList = [];
                  List<SubjectModel> currentSubjects = subjectList
                      .where((element) => element.academicId == academicId.getYearId() && element.classId == classIdProvider.getClassId()).toList();
                  if(snapshot2.hasData){
                    homework = snapshot2.data;
                    currentSubjects.forEach((element) {
                      HomeworkModel currentSubjectHomework =  homework.firstWhere((e) => e.subjectId == element.id && e.time == currentDateTime.toString(),orElse: ()=>null);
                      if(currentSubjectHomework != null){
                        print('true');
                        homeworkList.add(currentSubjectHomework);
                      }
                      else{
                        print('false');
                        HomeworkModel noHomework = HomeworkModel(subjectId: element.id,classId: element.classId,academicId: element.academicId,
                            subject: element.subject,time: currentDateTime.toString());
                        homeworkList.add(noHomework);
                      }
                    }
                    );
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 80,
                      mainAxisSpacing:5,
                      childAspectRatio: 1,
                      children:
                      List.generate(homeworkList.length, (index) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                addHomeworkInput(context,homeworkList[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffFFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xff707070).withOpacity(.4),
                                          offset: Offset(0, 0),
                                          blurRadius: 10),
                                    ]),
                                alignment: Alignment.center,
                                child: Text(homeworkList[index].subject,style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 30),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                homeworkList[index].givenBy == null?SizedBox():
                                Text('-By ${homeworkList[index].givenBy}',style: TextStyle(color:AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.w300),),
                              ],
                            )
                          ],
                        ),
                      ),),
                    );
                  }
                  return SizedBox();
                },
              );




            }
            else{
              return SizedBox();
            }

          },

        ),
      ),
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
                            classIdNotify.changeClassID(classList[index].id);

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
  addHomeworkInput(BuildContext context,HomeworkModel homework){

    return showPopupWindow(
      context,
      gravity: KumiPopupGravity.center,
      bgColor: Colors.grey.withOpacity(0.5),
      clickOutDismiss: true,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
      //childSize: null,
      underStatusBar: false,
      underAppBar: true,
      offsetX: 100,
      offsetY: -50,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return StatefulBuilder(
          key: GlobalKey(),
          builder: (context,StateSetter setState){
            return Container(
              key: GlobalKey(),
              height: 600,
              width: 900,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff707070).withOpacity(.4),
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    )
                  ]),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(),
                            SizedBox(),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width:200,
                                      child: TextField(
                                        controller: TextEditingController(text: homework.subject),
                                        style: TextStyle(
                                            color: Color(0xff263859),
                                            fontSize: SizeConfig.textScaleFactor * 20,
                                            fontWeight: FontWeight.bold),
                                        onChanged: (value){

                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                fontSize: SizeConfig.textScaleFactor * 15,
                                                fontWeight: FontWeight.w500),
                                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                                            border: InputBorder.none
                                        ),),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('By- ',style: TextStyle(
                                        color: AppColors.redAccent,
                                        fontSize: SizeConfig.textScaleFactor * 20,
                                        fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      width:200,
                                      child: TextField(
                                        controller: TextEditingController(text: homework.givenBy == null ? "":homework.givenBy),
                                        style: TextStyle(
                                            color: AppColors.redAccent,
                                            fontSize: SizeConfig.textScaleFactor * 20,
                                            fontWeight: FontWeight.w300),
                                        onChanged: (value){

                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Given By',
                                            hintStyle: TextStyle(
                                                fontSize: SizeConfig.textScaleFactor * 15,
                                                fontWeight: FontWeight.w500),
                                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                                            border: InputBorder.none
                                        ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            MaterialButton(
                              color:AppColors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(color: AppColors.white,fontSize: SizeConfig.textScaleFactor * 15),
                              ),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Divider(
                                thickness: .5,
                                color: Color(0xff6B778D).withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child:Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff707070).withOpacity(.4),
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                  )
                                ]),
                          ) ,
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          child:Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff707070).withOpacity(.4),
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                  )
                                ]),
                            child:Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                maxLines: 10,
                                controller: TextEditingController(text: homework == null?'':homework.description),
                                style: TextStyle(
                                    color: Color(0xff263859),
                                    fontSize: SizeConfig.textScaleFactor * 20,
                                    fontWeight: FontWeight.bold),
                                onChanged: (value){

                                },
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                    hintStyle: TextStyle(
                                        fontSize: SizeConfig.textScaleFactor * 15,
                                        fontWeight: FontWeight.w500),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                                    border: InputBorder.none
                                ),),
                            ),
                          ) ,
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Container(
                                width: 200,
                                height: 85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff707070).withOpacity(.4),
                                        offset: Offset(0, 0),
                                        blurRadius: 6,
                                      )
                                    ]),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff707070).withOpacity(.4),
                                            offset: Offset(0, 0),
                                            blurRadius: 6,
                                          )
                                        ]),
                                    alignment: Alignment.center,
                                    child: file != null ?Text(file.name):SizedBox(),
                                  ),
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: EdgeInsets.only(top: 45),
                                    child: GestureDetector(
                                      onTap: () async{
                                        file = await FilePicker.getFile();
                                        setState((){});
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Color(0xff263859),
                                        child: Transform.rotate(
                                            angle: 10,
                                            child: Icon(Icons.attach_file)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );

  }
}
String toHumanReadableDate(DateTime timestamp) {
  var moonLanding = timestamp;
  var jiffy = Jiffy([
    moonLanding.year,
    moonLanding.month,
    moonLanding.day,
    moonLanding.hour,
    moonLanding.minute,
    00,
  ]).format("dd,MMM");
  return jiffy;
}

