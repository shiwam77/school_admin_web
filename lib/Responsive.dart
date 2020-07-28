import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double textScaleFactor;
  static Function wp;
  static Function hp;
  void init(BuildContext context) {
    wp = Screen(MediaQuery.of(context).size).wp;
     hp = Screen(MediaQuery.of(context).size).hp;
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    textScaleFactor= MediaQuery.of(context).textScaleFactor;
  }
}