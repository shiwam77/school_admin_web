import 'package:flutter/material.dart';

import 'Utiity.dart';
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
    Container(
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
      child: loading(),
    ),);
  }
}
