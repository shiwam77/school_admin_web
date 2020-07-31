import 'package:flutter/material.dart';

import '../../Color.dart';
import '../../Responsive.dart';
import 'package:popup_box/popup_box.dart';
class Gender {
  String id;
  String gender;
  Gender(this.id, this.gender);

  static List<Gender> getGender= [
    Gender('0', 'Male'),
    Gender('1', 'Female'),
    Gender('2', 'Other'),

  ];
}
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
                child:screenHeader('Manage Class'),
              ),
              addClassWidget(),
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
              SizedBox(height: SizeConfig.hp(2),),
             Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: SizeConfig.wp(5),right: SizeConfig.wp(3)),
                          child: classFeaturesScreen(title: 'Subject',
                            child: ListView.builder(
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
                          onTapAddIcon: (){
                            print('hi');

                          }),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: SizeConfig.wp(3),right: SizeConfig.wp(5)),
                          child: classFeaturesScreen(title: 'Student',
                            child:ListView.builder(
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
                            onTapAddIcon: ()  {
                              popUpWindows(
                                child:AddStudentInput(),

                              );

                            }
                          ),
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
   Widget addClassWidget(){
    return Row(
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
    );
   }
  Widget classFeaturesScreen({String title,Widget child,Function onTapAddIcon,}){
    return Column(
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Color(0xff263859),
                  fontSize: SizeConfig.textScaleFactor * 25,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
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
              child,
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: onTapAddIcon,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Tooltip(
                      message: 'Add $title',
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
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Future<Widget> popUpWindows({Widget child,Function onSave}) async{
    return await PopupBox.showPopupBox(
        context: context,
        button: MaterialButton(
          color:AppColors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Save',
            style: TextStyle(fontSize: SizeConfig.textScaleFactor * 15),
          ),
          onPressed: () {
            onSave;
            Navigator.of(context).pop();
          },
        ),
        willDisplayWidget: child,
    );
  }

}


class AddStudentInput extends StatefulWidget {
  @override
  _AddStudentInputState createState() => _AddStudentInputState();
}

class _AddStudentInputState extends State<AddStudentInput> {
  List<DropdownMenuItem<Gender>> _dropdownMenuItems;
  Gender _selectedGender;
  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(Gender.getGender);
    setState(() {
      _selectedGender = _dropdownMenuItems[0].value;
      //subjectList = getSubject.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: SizeConfig.screenWidth * .5,
      height: SizeConfig.screenHeight * .75,
      child: Column(
        children: [
          CircleAvatar(
            radius: SizeConfig.hp(10),
            backgroundColor: AppColors.redAccent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Center(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                      child: DropdownButton(
                        icon: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF718096),
                          ),
                        ),
                        underline: Container(
                          height: 1,
                          color: Colors.transparent,
                        ),
                        items: _dropdownMenuItems,
                        value:_selectedGender,
                        onChanged: (Gender gender) {
                          setState(() {
                            _selectedGender = gender;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],),
          Container(
            height: 50,
            width: SizeConfig.screenWidth * .4,
          ),
          Container(

            height: SizeConfig.screenHeight * .4,
            width: SizeConfig.screenWidth * .4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff707070).withOpacity(.4),
                    offset: Offset(0, 0),
                    blurRadius: 15,
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: ListView(
                    children: [
                      formInput(label: "Roll No",
                          onChanged: (value){

                          }),
                      formInput(label: "Father's Name",
                      onChanged: (value){

                      }),
                      formInput(label: "Mother's Name",
                          onChanged: (value){

                          }),
                      formInput(label: "Address",
                          onChanged: (value){

                          }),
                      formInput(label: "D.O.B",
                          onChanged: (value){

                          }),
                      formInput(label: "Contact",
                          onChanged: (value){

                          }),
                      formInput(label: "Email",
                          onChanged: (value){

                          }),
                    ],
                  ),
                ),
          )
        ],
      ),
    );
  }
  Widget formInput({String label,Function onChanged}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        SizedBox(
          width: SizeConfig.wp(25),
          child: TextField(
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
  List<DropdownMenuItem<Gender>> buildDropDownMenuItems(
      List<Gender> getGender) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender gender in getGender) {
      items.add(DropdownMenuItem(
        value: gender,
        child: Text(gender.gender),
      ));
    }
    return items;
  }
}
