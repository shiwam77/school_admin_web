import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYear.dart';
import 'package:school_admin_web/Widget/CenterView.dart';

import '../../Color.dart';
import '../../Image.dart';
import '../../Responsive.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
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
            child: CenterView(
              child:   Row(
                children: [
                  Logo (),
                  //Spacer(),
                  Expanded(
                      child: SignForms()),
                  //Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class SignForms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:SizeConfig.hp(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Admin Login',
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: Color(0xffFF6768),
                            fontSize:SizeConfig.textScaleFactor * 55,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.hp(5),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: Color(0xffFFFFFF),
                  ),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      //textAlign: TextAlign.center,
                      enabled: true,
                      decoration: InputDecoration(
                        hintText: 'username',
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height:SizeConfig.hp(5),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: Color(0xffFFFFFF),
                  ),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      enabled: true,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.hp(5)),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      hoverColor: Color(0xffFF6768),
                      onTap: () {},
                      child: Text(
                        'Forget password?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            letterSpacing: .2,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.hp(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AcademicYear()));
                      },
                      child: Container(
                        width: 250,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Color(0xffFF6768),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
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
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          //margin:const EdgeInsets.symmetric(horizontal: 50),
          child: Image.asset(AppImages.appLogo),
          width:SizeConfig.wp(35),
          height:SizeConfig.hp(50),
        ),
      ],
    );
  }
}

