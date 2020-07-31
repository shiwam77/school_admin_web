import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Color.dart';
import '../../Responsive.dart';
class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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
                child:screenHeader('Attendance'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Date Picker',
                      maxLines: 2,
                      style: TextStyle(color: AppColors.redAccent,
                          fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.hp(2),),
              SizedBox(
                height: SizeConfig.hp(5),
                width:SizeConfig.wp(60),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height:SizeConfig.hp(5),
                        alignment: Alignment.center,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:AppColors.redAccent,
                        ),
                        child:Text('Class One'),);
                    }),
              ),
              SizedBox(height: SizeConfig.hp(2),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(4)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Roll No',style: TextStyle(color: AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold),),
                          Text('Student Name',style: TextStyle(color: AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          SizedBox(width: 50,),
                          Text('Present',style: TextStyle(color:Color(0xff39CE15),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('Absent',style: TextStyle(color: Color(0xffFF3B3B),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('On Leave',style: TextStyle(color: Color(0xff00B9BA),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                          Text('Holiday',style: TextStyle(color:Color(0xff6B778D),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.bold)),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(4)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                  width: double.infinity,
                  height: SizeConfig.hp(55),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff707070).withOpacity(.4),
                            offset: Offset(0, 0),
                            blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                        itemBuilder: (context,index){
                      return Container(
                        width: double.infinity,
                        height:  50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1.',style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w300)),
                            Text('Shiwam Karn',style: TextStyle(color: Color(0xff263859),fontWeight: FontWeight.w300),),
                            SizedBox(width: 20,),
                            CircleAvatar(
                              backgroundColor: Color(0xff39CE15),
                              radius: 15,
                                child: Text('P')),
                            CircleAvatar(
                                backgroundColor: Color(0xffFF3B3B),
                                radius: 15,
                                child: Text('A')),
                            CircleAvatar(
                                backgroundColor: Color(0xff00B9BA),
                                radius: 15,
                                child: Text('L')),
                            CircleAvatar(
                                backgroundColor: Color(0xff6B778D),
                                radius: 15,
                                child: Text('H')),
                          ],
                        )
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ));
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
