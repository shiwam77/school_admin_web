import 'dart:typed_data';

import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/StudentModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/SubjectModel.dart';
import 'package:school_admin_web/Screen/ClassSetup/ViewModel/StudentCRUD.dart';

import '../../Color.dart';
import '../../Responsive.dart';
import 'package:popup_box/popup_box.dart';

import 'Model/ClassModel.dart';
import 'Notifier/ClassIdNotifier.dart';
import 'ViewModel/classCRUD.dart';
import 'ViewModel/subjectCRUD.dart';

import 'package:image_picker_web/image_picker_web.dart';
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
  List<ClassModel> classList;
  List<SubjectModel> subjectList;
  int currentSelectedIndex;
  List<StudentModel> studentList;

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassViewModel >(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    final subjectProvider = Provider.of<SubjectViewModel >(context,listen: true);
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    final studentProvider = Provider.of<StudentViewModel>(context,listen: true);

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
                child: StreamBuilder(
                  stream:classProvider.fetchClassAsStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      classList = snapshot.data.documents.map((e) =>
                          ClassModel.fromMap(e.data, e.documentID))
                          .where((element) => element.academicYearId == academicId.getYearId()).toList();
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: classList.length,
                          itemBuilder: (context,index){
                            return Consumer<ClassNotifier>(
                              builder: (context,classIdNotify,child){
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      currentSelectedIndex = index;
                                      classIdNotify.changeClassID(classList[index].id);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    height:SizeConfig.hp(5),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:currentSelectedIndex == index ?AppColors.redAccent:AppColors.white,
                                    ),
                                    child:Text(classList[index].classes),),
                                );
                              },

                            );
                          },
                      );
                    }
                      else{
                        return Center(child: Text('Fetching..',style: TextStyle(color: AppColors.loginBackgroundColor),));
                    }
                    }

                ),
              ),
              SizedBox(height: SizeConfig.hp(2),),
              classIdProvider.getClassId() != null?Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: SizeConfig.wp(5),right: SizeConfig.wp(3)),
                            child: classFeaturesScreen(title: 'Subject',
                                child: StreamBuilder(
                                  stream: subjectProvider.fetchSubjectAsStream(),
                                  builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                    if(snapshot.hasData){
                                      subjectList = snapshot.data.documents.map((e) =>
                                          SubjectModel.fromMap(e.data, e.documentID))
                                          .where((element) =>element.academicId ==academicId.getYearId() && element.classId == classIdProvider.getClassId()).toList();
                                      return ListView.builder(
                                          itemCount:subjectList.length,
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
                                                  Text(subjectList[index].subject,style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 15),),
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
                                                    child: InkWell(
                                                        onTap: (){
                                                          subjectProvider.removeSubject(subjectList[index].id);
                                                        },
                                                        child: Text('Delete',style: TextStyle(color: AppColors.white,fontSize: 10),)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    else{
                                      return SizedBox();
                                    }

                                  },
                                ),
                                onTapAddIcon: () async{
                                  await  PopupBox.showPopupBox(
                                    context: context,
                                    button: SizedBox(),
                                    willDisplayWidget: AddSubjectInput(),
                                  );
                                }
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: SizeConfig.wp(3),right: SizeConfig.wp(5)),
                            child: classFeaturesScreen(title: 'Student',
                                child:StreamBuilder(
                                  stream: studentProvider.fetchStudentAsStream(),
                                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                    if(snapshot.hasData){
                                      studentList = snapshot.data.documents.map((e) =>
                                          StudentModel.fromMap(e.data, e.documentID))
                                          .where((element) =>element.academicId ==academicId.getYearId() && element.classId == classIdProvider.getClassId()).toList();
                                      return ListView.builder(
                                          itemCount: studentList.length,
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
                                                  Text(studentList[index].studentName,style: TextStyle(color: Color(0xff263859),fontSize: SizeConfig.textScaleFactor * 15),),
                                                  Spacer(),
                                                  Container(
                                                    height: 20,
                                                    width: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: AppColors.redAccent
                                                    ),
                                                    child: InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Text('Edit',style: TextStyle(color: AppColors.white,fontSize: 10),)),

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
                                                    child: InkWell(
                                                        onTap: (){
                                                          studentProvider.removeStudent(studentList[index].id);
                                                        },
                                                        child: Text('Delete',style: TextStyle(color: AppColors.white,fontSize: 10),)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    return SizedBox();
                                  },
                                ),
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
              ):SizedBox(),

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

    String classes;
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    final classProvider = Provider.of<ClassViewModel >(context,listen: true);
    TextEditingController textEditingController = TextEditingController();
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
              controller: textEditingController,
              cursorColor: AppColors.loginBackgroundColor,
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
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                classes = value;
              },

            ),
          ),
        ),
        SizedBox(width:SizeConfig.wp(2)),
        InkWell(
          onTap: () {
            if(classes.isNotEmpty){
              classProvider.addClass(ClassModel(classes: classes,academicYearId:academicId.getYearId()));
              textEditingController.clear();
              classes ='';
            }
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
        button: SizedBox(),
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
  Image pickedImage;
  Uint8List bytesFromPicker;
  Gender _selectedGender;
  String id;
  String academicId;
  String classId;
  String studentName;
  String rollNo;
  String fatherName;
  String motherName;
  String address;
  String emailAddress;
  String dateOfBirth;
  String contact;
  String gender;
  String imageUrl;
  String imagePath;
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
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    final studentProvider = Provider.of<StudentViewModel>(context,listen: true);
    return  Container(
      width: SizeConfig.screenWidth * .5,
      height: SizeConfig.screenHeight * .75,
      child: ListView(
        children: [
          Tooltip(
            message:bytesFromPicker == null ? 'Tap to insert image':'Tap to edit image',
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(4),
            child: GestureDetector(
              onTap:  pickImageAsByte,
              child: Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,

                      ),
                alignment: Alignment.center,
                child:bytesFromPicker != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                    child: Image.memory(
                      bytesFromPicker,
                      fit:BoxFit.fill,width: 170,height: 170,
                      filterQuality: FilterQuality.high,
                    )):Icon(
                  Icons.account_circle,
                  size: 210,
                  color: AppColors.redAccent,),
                  ),
            ),
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
         SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:SizeConfig.wp(3) ),
            child: Container(
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
                            setState(() {
                              rollNo = value;
                            });
                            }),
                        formInput(label: "Father's Name",
                        onChanged: (value){
                        setState(() {
                          fatherName = value;
                        });
                        }),
                        formInput(label: "Mother's Name",
                            onChanged: (value){
                              setState(() {
                              motherName = value;
                              });
                            }),
                        formInput(label: "Address",
                            onChanged: (value){
                            setState(() {
                              address = value;
                            });
                            }),
                        formInput(label: "D.O.B",
                            hintText: "dd/mm/yyy",
                            onChanged: (value){
                            setState(() {
                              dateOfBirth = value;
                            });
                            }),
                        formInput(label: "Contact",
                            onChanged: (value){
                             setState(() {
                               contact = value;
                             });
                            }),
                        formInput(label: "Email",
                            onChanged: (value){
                            setState(() {
                              emailAddress = value;
                            });
                            }),
                      ],
                    ),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color:AppColors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: SizeConfig.textScaleFactor * 15),
                  ),
                  onPressed: () {
                     studentProvider.addStudent(StudentModel(
                       academicId: academicId.getYearId(),
                       classId: classIdProvider.getClassId(),
                       studentName: studentName,
                       rollNo: rollNo,
                       fatherName: fatherName,
                       motherName: motherName,
                       dateOfBirth: dateOfBirth,
                       address: address,
                       contact: contact,
                       emailAddress: emailAddress,
                       gender: _selectedGender.gender,
                       imagePath: '',
                       imageUrl: '',
                     ));
                    Navigator.of(context).pop();
                  },
                ),
            ],),
          )
        ],
      ),
    );
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

  Widget formInput({String label,Function onChanged,String hintText}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        SizedBox(
          width: SizeConfig.wp(25),
          child: TextField(
            onChanged: onChanged,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hintText == null?'':hintText,
            ),
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





class AddSubjectInput extends StatefulWidget {
  AddSubjectInput({Key key}):super(key:key);
  @override
  _AddSubjectInputState createState() => _AddSubjectInputState();
}

class _AddSubjectInputState extends State<AddSubjectInput> {
  TextEditingController _textEditingController = TextEditingController();
  String subject;
  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectViewModel >(context,listen: true);
    final classIdProvider = Provider.of<ClassNotifier>(context,listen: true);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
    return Consumer<ClassNotifier>(
    builder: (context,classIdNotify,child){
      return Column(
        children: [
          Container(
            child:SizedBox(
              width:SizeConfig.wp(20),
              height: 47,
              child: TextField(
                controller: _textEditingController,
                style: TextStyle(
                    color: Color(0xff263859),
                    fontSize: SizeConfig.textScaleFactor * 35,
                    fontWeight: FontWeight.bold),
                onChanged: (value){
                  setState(() {
                    subject = value;
                  });
                  print(subject);
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color:AppColors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: SizeConfig.textScaleFactor * 15),
                ),
                onPressed: () {
                  if(subject.isNotEmpty){
                    subjectProvider.addSubject(SubjectModel(subject:subject,academicId: academicId.getYearId(),classId:classIdNotify.getClassId()));
                    subject ='';
                    _textEditingController.clear();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },

    );
  }
}

