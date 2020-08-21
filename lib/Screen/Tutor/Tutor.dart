import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';

import '../../Color.dart';
import '../../Responsive.dart';
class Tutor extends StatefulWidget {
  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  List<ClassModel> classList;
  int currentSelectedIndex;
  DateTime currentDateTime =DateTime.now();
  @override
  Widget build(BuildContext context) {
    final classIdProvider = Provider.of<fetchingClassIDNotifier>(context,listen: true);
    return Expanded(
        child:Container(
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
                child:screenHeader('Tutor'),
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
}
