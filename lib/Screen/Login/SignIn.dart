import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Color.dart';
import '../../Image.dart';
import '../../Responsive.dart';

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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        //margin:const EdgeInsets.symmetric(horizontal: 50),
                        child: Image.asset(AppImages.appLogo),
                        width: 650,
                        height: 350,
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Admin Login',
                                  style: TextStyle(
                                      color: Color(0xffFF6768),
                                      fontSize: 75,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .2),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 53,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                color: Color(0xffFFFFFF),
                              ),
                              child: SizedBox(
                                width: 440,
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
                                    fillColor: Color(0xffFFFFFF),
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
                              height: 53,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                color: Color(0xffFFFFFF),
                              ),
                              child: SizedBox(
                                width: 440,
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
                                    fillColor: Color(0xffFFFFFF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            SizedBox(height: 47),
                            SizedBox(
                              width: 440,
                              child: Row(
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 47,
                            ),
                            Container(
                              width: 440,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
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
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                //Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
