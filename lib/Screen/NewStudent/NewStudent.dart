import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Color.dart';

import '../../Responsive.dart';

class NewStudent extends StatefulWidget {
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 40,top: 20,right: 40,bottom: 10),
            child:screenHeader('Add Student'),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.wp(5)),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: SizeConfig.wp(50),
                            alignment: Alignment.center,
                            child: Text('DELHI INSTITUTE OF TECHNOLOGY AND MANAGEMENT ',
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(color: AppColors.redAccent,
                                  fontSize: SizeConfig.textScaleFactor * 30,fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('131101 Ganaur,Sonipat',
                                softWrap: true,
                                style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 15,fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: SizeConfig.hp(10),
                        backgroundColor: AppColors.redAccent,
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(2)),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff707070).withOpacity(.4),
                              offset: Offset(0, 0),
                              blurRadius: 12,
                            )
                          ]),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:SizeConfig.wp(5.5),vertical: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.hp(6),
                                  backgroundColor: AppColors.redAccent,
                                  child: Icon(Icons.add,color: AppColors.white,size: 30,),
                                ),
                                SizedBox(width: 20,),
                                SizedBox(
                                  width:SizeConfig.wp(20),
                                  height: 47,
                                  child: TextField(
                                    style: TextStyle(
                                        color: Color(0xff263859),
                                        fontSize: SizeConfig.textScaleFactor * 35,
                                        fontWeight: FontWeight.bold),
                                    onSubmitted: (value){
                                      setState(() {

                                      });
                                    },
                                    onEditingComplete: (){
                                      setState(() {
                                        //subjTileText = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Enter Student Name',
                                        hintStyle: TextStyle(
                                            fontSize: SizeConfig.textScaleFactor * 20,
                                            fontWeight: FontWeight.w500),
                                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        border: InputBorder.none
                                    ),),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(5)),
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 45,
                              width:double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff707070).withOpacity(.4),
                                      offset: Offset(0, 0),
                                      blurRadius: 6,
                                    )
                                  ]),
                               child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 20),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Padding(
                                       padding: EdgeInsets.symmetric(vertical: 20),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.baseline,
                                             textBaseline: TextBaseline.alphabetic,
                                             children: [
                                               label(tittle: 'Roll No'),
                                               label(tittle: "Father's Name"),
                                               label(tittle: 'Address'),
                                               label(tittle: 'Contact'),
                                               label(tittle: 'Address'),
                                             ],
                                           ),
                                           SizedBox(width: 5,),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.baseline,
                                             textBaseline: TextBaseline.alphabetic,
                                             children: [
                                               label(tittle: 'D.O.B'),
                                               label(tittle: "Mother's Name"),
                                               label(tittle: 'Email Address'),
                                               label(tittle: 'Parents Contact'),

                                             ],
                                           ),
                                           SizedBox(width: 5,),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.wp(15),
                                                 child: TextField(
                                                   onChanged: (value){},
                                                 ),
                                               ),

                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 )
                               ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100,top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,children: [
                              MaterialButton(
                                color:AppColors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: AppColors.white,fontSize: SizeConfig.textScaleFactor * 15),
                                ),
                                onPressed: () {

                                },
                              ),
                            ],),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),

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
  Widget label({String tittle}){
    return  Container(height:45,alignment:Alignment(0,1),child: Text(tittle));
  }
}
