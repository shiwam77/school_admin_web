import 'package:flutter/material.dart';
import 'package:school_admin_web/Screen/ClassSetup/ManageClass.dart';
import 'package:school_admin_web/Screen/Home/Home.dart';
import 'package:school_admin_web/Widget/CenterView.dart';

import '../../Color.dart';
import '../../Image.dart';
import '../../Responsive.dart';
import 'Masterpage.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget screen = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ManageClass(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
