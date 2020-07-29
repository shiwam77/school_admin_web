import 'package:flutter/material.dart';

import '../../Color.dart';
import '../../Responsive.dart';

class ManageClass extends StatefulWidget {
  @override
  _ManageClassState createState() => _ManageClassState();
}

class _ManageClassState extends State<ManageClass> {
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20),
                child: Row(
                  children: [
                    Text(
                      'Manage Class',
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Class',
                    style: TextStyle(
                        color: Color(0xffFF6768),
                        fontSize: SizeConfig.textScaleFactor * 30,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width:SizeConfig.wp(2)),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.4),
                            offset: Offset(0, 0),
                            blurRadius: 12,
                          ),
                        ]),
                    child: SizedBox(
                      height: SizeConfig.hp(6),
                      child: TextField(
                        cursorColor: AppColors.white,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: .2,
                        ),
                        enabled: true,

                        decoration: InputDecoration(
                          hintText: 'Enter Class',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            letterSpacing: .2,
                          ),
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
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(width:SizeConfig.wp(2)),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: SizeConfig.wp(7),
                      height: SizeConfig.hp(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xffFF6768),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(.4),
                              offset: Offset(0, 0),
                              blurRadius: 12,
                            ),
                          ]
                      ),
                      alignment: Alignment.center,
                      child:Icon(Icons.arrow_downward,color: AppColors.white,size: 40,)
                    ),
                  ),
                  SizedBox(width:SizeConfig.wp(2)),

                ],
              ),
              SizedBox(height: SizeConfig.hp(5),),
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
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.wp(9),vertical: 10),
                child: Column(children: [
                  Divider(
                    thickness: .5,
                    height: .5,
                    color: Color(0xff6B778D).withOpacity(.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 40,

                        decoration: BoxDecoration(
                            color: AppColors.redAccent,
                            borderRadius: BorderRadius.circular(2)
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: .5,
                    height: 1,
                    color: Color(0xff6B778D).withOpacity(.5),
                  )
                ],),
              ),
             Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Subject',
                                  style: TextStyle(
                                      color: Color(0xff263859),
                                      fontSize: SizeConfig.textScaleFactor * 25,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(100,10,20,40),
                              child: Container(
                                height: SizeConfig.hp(50),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff707070).withOpacity(.4),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                      )
                                    ]),
                                 child: Stack(
                                   children: [
                                     ListView.builder(
                                       itemCount: 10,
                                         itemBuilder: (context,index){
                                       return Container(
                                         margin: EdgeInsets.symmetric(horizontal: 40),
                                         width: double.infinity,
                                         height: 50,
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             Container(
                                               height: 10,
                                               width: 10,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(8),
                                                 color: AppColors.redAccent
                                               ),
                                             ),
                                             SizedBox(width:20,),
                                             Text('Subject ${index + 1}',style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 15),),
                                             Spacer(),
                                             Container(
                                               height: 20,
                                               width: 35,
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10),
                                                   color: AppColors.redAccent
                                               ),
                                               child: Text('Edit',style: TextStyle(color: AppColors.white,fontSize: 10),),
                                             ),
                                             SizedBox(width:20,),
                                             Container(
                                               height: 20,
                                               width: 40,
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10),
                                                   color: AppColors.redAccent
                                               ),
                                               child: Text('Delete',style: TextStyle(color: AppColors.white,fontSize: 10),),
                                             ),
                                           ],
                                         ),
                                       );
                                     }),
                                     Align(
                                       alignment: Alignment.bottomRight,
                                       child: InkWell(
                                         onTap: (){},
                                         child: Padding(
                                           padding: const EdgeInsets.all(10.0),
                                           child: Container(
                                               height: 50,
                                               width: 50,
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(25),
                                                 color: Color(0xff263859),
                                               ),
                                               child: Icon(Icons.add,color: AppColors.white,)),
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Student',
                                  style: TextStyle(
                                      color: Color(0xff263859),
                                      fontSize: SizeConfig.textScaleFactor * 25,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20,10,100,40),
                              child: Container(
                                height: SizeConfig.hp(50),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff707070).withOpacity(.4),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                      )
                                    ]),
                                child: Stack(
                                  children: [
                                    ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context,index){
                                          return Container(
                                            margin: EdgeInsets.symmetric(horizontal: 40),
                                            width: double.infinity,
                                            height: 50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: AppColors.redAccent
                                                  ),
                                                ),
                                                SizedBox(width:20,),
                                                Text('Shiwam ${index + 1}',style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 15),),
                                                Spacer(),
                                                Container(
                                                  height: 20,
                                                  width: 35,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.redAccent
                                                  ),
                                                  child: Text('Edit',style: TextStyle(color: AppColors.white,fontSize: 10),),
                                                ),
                                                SizedBox(width:20,),
                                                Container(
                                                  height: 20,
                                                  width: 40,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.redAccent
                                                  ),
                                                  child: Text('Delete',style: TextStyle(color: AppColors.white,fontSize: 10),),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: Color(0xff263859),
                                              ),
                                              child: Icon(Icons.add,color: AppColors.white,)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ));
  }
}


