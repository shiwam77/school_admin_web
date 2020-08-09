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

