import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Model/AcademicYear.dart';

import '../../Color.dart';
import '../../Image.dart';
import '../../Responsive.dart';

class AcademicYear extends StatefulWidget {
  @override
  _AcademicYearState createState() => _AcademicYearState();
}

class _AcademicYearState extends State<AcademicYear> {
  ListOfYear yearsList = ListOfYear();
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  String _year;
  @override
  Widget build(BuildContext context) {
    return Material(
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
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //margin:const EdgeInsets.symmetric(horizontal: 50),
                        child: Image.asset(AppImages.appLogo),
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 200),
                              child: Container(
                                width: 350,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    SizedBox(
                                      height: 40,
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
                                              fontSize: 45,
                                              letterSpacing: .2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
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
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            if (_year.isNotEmpty) {
                                              setState(() {
                                                Year year = Year(
                                                    id: UniqueKey().toString(),
                                                    year: _year);
                                                yearsList.getYear.add(year);
                                                _textEditingController.clear();
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 45,
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
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 200),
                              child: Container(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Your data is here',
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        height: 400,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                color: Color(0xffFFFFFF))),
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          isAlwaysShown: true,
                                          child: ListView.builder(
                                              controller: _scrollController,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  yearsList.getYear.length,
                                              itemBuilder: (context, index) =>
                                                  CustomListTile(index)),
                                        )),
                                    Spacer()
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CustomListTile(int index) {
    return Padding(
      key: ValueKey(index),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            Text(yearsList.getYear[index].year,
                style: TextStyle(fontSize: 18, color: Color(0xffFFFFFF))),
            Spacer(),
            Text(
              'Edit',
              style: TextStyle(fontSize: 13, color: Color(0xffFFFFFF)),
            ),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  yearsList.getYear.removeAt(index);
                });
              },
              child: Text('Delete',
                  style: TextStyle(fontSize: 13, color: Color(0xffFF6768))),
            ),
          ],
        ),
      ),
    );
  }
}
