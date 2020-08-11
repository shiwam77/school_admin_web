import 'package:age/age.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Color.dart';
import 'Responsive.dart';

AgeDuration getAge({DateTime birthDate}){
  AgeDuration age;
  DateTime birthday = birthDate;
  DateTime today = DateTime.now();
  age = Age.dateDifference(
      fromDate: birthday, toDate: today, includeToDate: false);
  return age;
}

Widget loading(){
  return Center(child: Container(
    height: 90,
    width: 350,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppColors.loginBackgroundColor,
    ),

    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingFour(
            color: AppColors.redAccent,
            size: 30.0,

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                height: 2,
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
      ),
    ),
  ));
}