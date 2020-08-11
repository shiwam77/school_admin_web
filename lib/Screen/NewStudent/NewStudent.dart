import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Color.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/ClassModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/StudentModel.dart';

import 'package:school_admin_web/Screen/ClassSetup/ViewModel/StudentCRUD.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/classCRUD.dart';

import '../../Responsive.dart';

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


class NewStudent extends StatefulWidget {
 final List<ClassModel> classList;
  NewStudent({this.classList});
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  List<DropdownMenuItem<Gender>> _dropdownMenuItems;
  Image pickedImage;
  Uint8List bytesFromPicker;
  Gender _selectedGender;
  String id;
  String academicId;
  String studentName;
  String rollNo;
  String fatherName;
  String motherName;
  String address;
  String emailAddress;
  String dateOfBirth ;
  String contact;
  String imageUrl;
  String imagePath;
  String parentsContact;
  ClassModel _selectedClass;
  TextEditingController studentController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController parentsContactController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  List<DropdownMenuItem<ClassModel>> _dropdownMenuItemsClass;
  List<DropdownMenuItem<Gender>> buildDropDownMenuItems(
      List<Gender> getGender) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender gender in getGender) {
      items.add(DropdownMenuItem(
        value: gender,
        child: Text(gender.gender,style: TextStyle(color: AppColors.redAccent),),
      ));
    }
    return items;
  }
  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(Gender.getGender);
    _dropdownMenuItemsClass = buildDropDownMenuItemsClass(widget.classList);
    setState(() {
      _selectedGender = _dropdownMenuItems[0].value;
      _selectedClass = _dropdownMenuItemsClass[0].value;
    });
  }


  @override
  Widget build(BuildContext context) {
    final academicIdProvider  = Provider.of<YearNotifier>(context,listen: true);
    final classProvider = Provider.of<ClassViewModel>(context,listen: true);
    final studentProvider = Provider.of<StudentViewModel>(context,listen: true);
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
      child:Column(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:SizeConfig.wp(5.5),vertical: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    pickImageAsByte();
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppColors.redAccent,
                                    child: bytesFromPicker != null ? ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.memory(
                                          bytesFromPicker,
                                          fit:BoxFit.fill,width: 170,height: 170,
                                          filterQuality: FilterQuality.high,
                                        )):Icon(Icons.add,color: AppColors.white,size: 30,),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:SizeConfig.wp(20),
                                      height: 47,
                                      child: TextField(
                                        controller: studentController,
                                        style: TextStyle(
                                            color: Color(0xff263859),
                                            fontSize: SizeConfig.textScaleFactor * 35,
                                            fontWeight: FontWeight.bold),
                                        onChanged: (value){
                                          setState(() {
                                          studentName = value;
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
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:120,
                                          height: 47,
                                          child: TextField(
                                            controller: rollNoController,
                                            style: TextStyle(
                                                color: Color(0xff263859),
                                                fontSize: SizeConfig.textScaleFactor * 20,
                                                fontWeight: FontWeight.bold),
                                            onChanged: (value){
                                              setState(() {
                                              rollNo = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'Roll No',
                                                hintStyle: TextStyle(
                                                    fontSize: SizeConfig.textScaleFactor * 15,
                                                    fontWeight: FontWeight.w500),
                                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                border: InputBorder.none
                                            ),),
                                        ),
                                        Container(
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                                            child: DropdownButton(
                                              icon: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                      ],
                                    ),
                                  ],
                                ),

                                Spacer(),
                                Tooltip(
                                  message: 'Select Class',
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient:LinearGradient(colors: [AppColors.redAccent,AppColors.loginBackgroundColor,]),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                                    child: DropdownButton(
                                      icon: SizedBox(),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.transparent,
                                      ),
                                      items: _dropdownMenuItemsClass,
                                      value:_selectedClass,
                                      onChanged: (ClassModel classes) {
                                        setState(() {
                                          _selectedClass = classes;
                                        });
                                      },
                                    ),
                                  ),
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
                                                label(tittle: "Father's Name"),
                                                label(tittle: 'Contact'),
                                                label(tittle: 'Address'),
                                                label(tittle: 'Skill'),
                                              ],
                                            ),
                                            SizedBox(width: 5,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: fatherNameController,
                                                    onChanged: (value){
                                                      fatherName = value;
                                                    },
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: contactController,
                                                    onChanged: (value){
                                                     contact = value;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: addressController,
                                                    onChanged: (value){
                                                      address = value;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: parentsContactController,
                                                    onChanged: (value){
                                                      parentsContact = value;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                label(tittle: "Mother's Name"),
                                                label(tittle: 'D.O.B'),
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
                                                    controller: motherNameController,
                                                    onChanged: (value){
                                                      motherName = value;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: dateOfBirthController,
                                                    onChanged: (value){
                                                      dateOfBirth = value;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller:emailAddressController ,
                                                    onChanged: (value){
                                                      emailAddress = value;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.wp(15),
                                                  child: TextField(
                                                    controller: skillController,
                                                    onChanged: (value){

                                                    },
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
                                  if(studentName.isNotEmpty && rollNo.isNotEmpty){
                                    StudentModel student = StudentModel(studentName: studentName,rollNo: rollNo,gender: _selectedGender.gender,classId: _selectedClass.id,academicId: academicIdProvider.getYearId(),
                                    dateOfBirth: dateOfBirth,fatherName: fatherName,motherName: motherName,contact: contact,address: address,
                                    emailAddress: emailAddress,parentsContact: parentsContact,);
                                   studentProvider.addStudent(student);
                                   setState(() {
                                     studentName ='';
                                     rollNo ='';
                                     fatherName ='';
                                     motherName='';
                                     contact ='';
                                     address='';
                                     emailAddress='';
                                     dateOfBirth='';
                                     parentsContact='';
                                     studentController.clear();
                                     rollNoController.clear();
                                     fatherNameController.clear();
                                     motherNameController.clear();
                                     contactController.clear();
                                     dateOfBirthController.clear();
                                     parentsContactController.clear();
                                     addressController.clear();
                                     skillController.clear();
                                     emailAddressController.clear();
                                   });
                                  }
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
  List<DropdownMenuItem<ClassModel>> buildDropDownMenuItemsClass(
      List<ClassModel> getClass) {
    List<DropdownMenuItem<ClassModel>> items = List();
    for (ClassModel classes in getClass) {
      items.add(DropdownMenuItem(
        value: classes,
        child: Text(classes.classes,
          style: TextStyle(color: AppColors.redAccent,
              fontSize: SizeConfig.textScaleFactor * 20,),
          maxLines: 1,),
      ));
    }
    return items;
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
  pickImage() async {
    Image fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget);

    if (fromPicker != null) {
      setState(() {
        pickedImage = fromPicker;
      });
    }
  }

  pickImageAsByte() async {
    Uint8List bytesPicker =
    await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (bytesPicker != null) {
      setState(() {
        bytesFromPicker = bytesPicker;
      });

    }
  }

}
