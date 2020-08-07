class StudentModel {
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
  StudentModel({this.id, this.studentName,this.classId,this.academicId,this.gender,this.address,this.contact,this.dateOfBirth,
  this.emailAddress,this.fatherName,this.imageUrl,this.motherName,this.rollNo,this.imagePath});
  StudentModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        academicId = snapshot['academicId'] ?? '',
        classId = snapshot['classId'] ?? '',
        studentName = snapshot['studentName'] ?? '',
        rollNo = snapshot['rollNo'] ?? '',
        fatherName = snapshot['fatherName'] ?? '',
        motherName = snapshot['motherName'] ?? '',
        address = snapshot['address'] ?? '',
        emailAddress = snapshot['emailAddress'] ?? '',
        dateOfBirth = snapshot['dateOfBirth'] ?? '',
        contact = snapshot['contact'] ?? '',
        gender = snapshot['gender'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '',
        imagePath = snapshot['imagePath'] ?? ''
        ;
  toJson() {
    return {
      "studentName": studentName,
      "classId":classId,
      "academicId":academicId,
      "rollNo":rollNo,
      "fatherName":fatherName,
      "motherName":motherName,
      "address":address,
      "emailAddress":emailAddress,
      "dateOfBirth":dateOfBirth,
      "contact":contact,
      "gender":gender,
      "imageUrl":imageUrl,
      "imagePath":imagePath,
    };
  }
}