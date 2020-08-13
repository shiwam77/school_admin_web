class AttendanceModel {
  String id;
  String academicId;
  String classId;
  String studentId;
  String studentName;
  String rollNo;
  String date;
  String imageUrl;
  String attendance;
  AttendanceModel({this.id, this.academicId,this.rollNo,this.studentName,this.date,this.imageUrl,this.attendance,this.classId,this.studentId});
  AttendanceModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        academicId = snapshot['academicId'] ?? '',
        classId = snapshot['classID'] ?? '',
        studentId = snapshot['studentId'] ?? '',
        studentName = snapshot['studentName'] ?? '',
        rollNo = snapshot['rollNo'] ?? '',
        date = snapshot['date'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '',
        attendance = snapshot['attendance'] ?? '';
  toJson() {
    return {
      "academicId": academicId,
      "classID": classId,
      "studentId": studentId,
      "studentName": studentName,
      "rollNo": rollNo,
      "date": date,
      "imageUrl": imageUrl,
      "attendance": attendance,
    };
  }
}
