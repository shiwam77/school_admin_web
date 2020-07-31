import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Color.dart';
import '../../Responsive.dart';

class HomeWork extends StatefulWidget {
  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
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
            child:screenHeader('Home Task'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please select the class below',
                maxLines: 2,
                style: TextStyle(color: AppColors.redAccent,
                    fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold),
              ),
            ],
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(10)),
            child: Container(
              width: double.infinity,
              height: SizeConfig.blockSizeVertical * 65,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
              crossAxisSpacing: 80,
              mainAxisSpacing:10,
              childAspectRatio: 1,
              children:
                List.generate(10, (index) => Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff707070).withOpacity(.4),
                                    offset: Offset(0, 0),
                                    blurRadius: 10),
                              ]),
                          alignment: Alignment.center,
                          child: Text('English',style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 30),),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('-By Shiwam',style: TextStyle(color:AppColors.redAccent,fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.w300),),
                        ],
                      )
                    ],
                  ),
                ),),
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
