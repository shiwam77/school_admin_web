class SubjectModel {
  String id;
  String academicId;
  String classId;
  String subject;
  SubjectModel({this.id, this.subject,this.classId,this.academicId});
  SubjectModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        classId = snapshot['classId'] ?? '',
        subject = snapshot['subject'] ?? '',
       academicId = snapshot['academicId'] ?? '';
  toJson() {
    return {
      "subject": subject,
      "classId":classId,
      "academicId":academicId,
    };
  }
}