
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/SubjectModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Notifier/ClassIdNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/subjectCRUD.dart';

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
  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassViewModel >(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    final subjectProvider = Provider.of<SubjectViewModel >(context,listen: true);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please select the class below',
                maxLines: 2,
                style: TextStyle(color: AppColors.redAccent,
                    fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.hp(2),),
          classTile(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(10)),
            child: Container(
              width: double.infinity,
              height: SizeConfig.blockSizeVertical * 65,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
              crossAxisSpacing: 80,
              mainAxisSpacing:10,
              childAspectRatio: 1,
              children:
                List.generate(10, (index) => Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
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
                          child: Text('English',style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 30),),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('-By Shiwam',style: TextStyle(color:AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.w300),),
                        ],
                      )
                    ],
                  ),
                ),),
                ),
            ),
          )
        ],
      ),
    ));
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
}
