import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Color.dart';
import 'package:school_admin_web/Image.dart';
import 'package:school_admin_web/Responsive.dart';
import 'package:school_admin_web/Screen/AcademicYear/Model/AcademicYearModel.dart';
import 'package:school_admin_web/Screen/MasterDetailScreen/DashBoard.dart';

import 'package:school_admin_web/Widget/CenterView.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'AcademicYearChangeNotifier.dart';
import 'ViewModel/CrudViewModel.dart';

class AcademicYear extends StatefulWidget {
  @override
  _AcademicYearState createState() => _AcademicYearState();
}

class _AcademicYearState extends State<AcademicYear> {
  List<AcademicModel> yearsList;
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  String _year;
  @override
  Widget build(BuildContext context) {
    final academicYearProvider = Provider.of<AcademicYearViewModel>(context,listen: true);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: ChangeNotifierProvider<AcademicYearViewModel>(
          create: (_) => AcademicYearViewModel(),
          child: Stack(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: AppColors.loginBackgroundColor,
                child: Image.asset(
                  AppImages.backgroundShape,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                child: CenterView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //margin:const EdgeInsets.symmetric(horizontal: 50),
                            child: Hero(
                                tag: 'logo',
                                child: Image.asset(AppImages.appLogo)),
                            width: SizeConfig.wp(20),
                            height:SizeConfig.hp(20)
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.wp(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      SizedBox(
                                        height:SizeConfig.hp(10),
                                      ),
                                      Row(
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Academic Year',
                                              overflow: TextOverflow.visible,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Color(0xffFF6768),
                                                fontSize: SizeConfig.textScaleFactor * 35,
                                                letterSpacing: .2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeConfig.hp(5),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                          color: Color(0xffFFFFFF),
                                        ),
                                        child: SizedBox(
                                          child: TextField(
                                            controller: _textEditingController,
                                            enabled: true,
                                            decoration: InputDecoration(
                                              hintText: 'Enter academic year',
                                              hintStyle: TextStyle(fontSize: 20),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              _year = value;
                                            },
                                            onSubmitted: (value) {},
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:SizeConfig.hp(2.5),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.black,
                                            onTap: () {
                                              if (_year.isNotEmpty) {
                                                  academicYearProvider.addYear(AcademicModel(year: _year));
                                                  _textEditingController.clear();
                                              }
                                              _year = "";
                                            },
                                            child: Container(
                                              width: SizeConfig.wp(8),
                                              height:SizeConfig.hp(7),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                color: Color(0xffFF6768),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Enter',
                                                style: TextStyle(
                                                    color: Color(0xffffffff),
                                                    fontSize: SizeConfig.textScaleFactor * 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.wp(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Choose academic year',
                                            overflow: TextOverflow.visible,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: SizeConfig.textScaleFactor * 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                       Container(
                                               height: SizeConfig.hp(40),
                                               child: Scrollbar(
                                                 controller: _scrollController,
                                                 child: StreamBuilder(
                                                   stream: academicYearProvider.fetchYearAsStream(),
                                                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                                     if(snapshot.hasData){
                                                       yearsList = snapshot.data.documents.map((e) =>
                                                           AcademicModel.fromMap(e.data, e.documentID)).toList();
                                                       return ListView.builder(
                                                           controller: _scrollController,
                                                           scrollDirection: Axis.vertical,
                                                           itemCount:
                                                           yearsList.length,
                                                           itemBuilder: (context, index) {

                                                             return  CustomListTile(index);
                                                           }
                                                       );
                                                     }
                                                     else{
                                                       return Column(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: [
                                                           SpinKitFadingFour(
                                                             color: AppColors.redAccent,
                                                             size: 50.0,

                                                           ),
                                                           SizedBox(height: 10,),
                                                           Row(
                                                             mainAxisAlignment: MainAxisAlignment.start,
                                                             crossAxisAlignment: CrossAxisAlignment.baseline,
                                                             textBaseline: TextBaseline.alphabetic,
                                                             children: [
                                                               Container(
                                                                 margin: EdgeInsets.only(top: 25),
                                                                 height: 3,
                                                                 width: 90,
                                                                 color: AppColors.redAccent,
                                                               ),

                                                               Text(' LOADING',style: TextStyle(color: AppColors.white,letterSpacing: 10,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold),),
                                                               TyperAnimatedTextKit(
                                                                   text: [
                                                                     '...'
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
                                                           ),
                                                         ],
                                                       );
                                                     }
                                                   },
                                                 ),
                                               ),
                                             ),

                                    ],
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomListTile(int index) {
    final academicYearProvider = Provider.of<AcademicYearViewModel>(context,listen: true);
    return Consumer<YearNotifier>(
        builder: (context,selectedYear,child) {
          return
            InkWell(
              onTap: () {
                selectedYear.changeYearId(yearsList[index].id);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context,) => DashBoard(academicYear: yearsList[index].id,)));
              },
              child: Padding(
                key: ValueKey(index),
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 20),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Transform.rotate(
                          angle: 90 * pi / 180,
                          child: Icon(
                            Icons.touch_app,
                            color: Colors.white,
                            size: 18,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Text(yearsList[index].year,
                          style: TextStyle(
                              fontSize: 18, color: Color(0xffFFFFFF))),
                      Spacer(),
                      Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 13, color: Color(0xffFFFFFF)),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await academicYearProvider.removeYear(
                              yearsList[index].id);
                        },
                        child: Text('Delete',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xffFF6768))),
                      ),
                    ],
                  ),
                ),
              ),
            );
        } );
  }

}
