import 'package:flutter/material.dart';

import '../../Responsive.dart';
class ExamSchedule extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedule> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
              child:screenHeader('Exam Schedule'),
            ),
          ],
        ),
      ),);
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
