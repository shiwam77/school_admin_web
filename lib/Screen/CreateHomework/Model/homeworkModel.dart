class HomeworkModel{
  String id;
  String academicId;
  String classId;
  String subjectId;
  String subject;
  String givenBy;
  String taskTittle;
  String chapter;
  String description;
  String comment;
  String pdfUrl;
  String time;
  HomeworkModel({this.id, this.subjectId,this.classId,this.academicId,this.pdfUrl,this.chapter,this.comment,this.description
  ,this.givenBy,this.taskTittle,this.time,this.subject});
  HomeworkModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        classId = snapshot['classId'] ?? '',
        subjectId = snapshot['subjectId'] ?? '',
        academicId = snapshot['academicId'] ?? '',
        givenBy = snapshot['givenBy'] ?? '',
        taskTittle = snapshot['taskTittle'] ?? '',
        chapter = snapshot['chapter'] ?? '',
        description = snapshot['description'] ?? '',
        comment = snapshot['comment'] ?? '',
        pdfUrl = snapshot['pdfUrl'] ?? '',
        time = snapshot['time'] ?? '',
        subject = snapshot['subject'] ?? '';
  toJson() {
    return {
      "subjectId": subjectId,
      "classId":classId,
      "academicId":academicId,
      "givenBy":givenBy,
      "taskTittle":taskTittle,
      "chapter":chapter,
      "pdfUrl":pdfUrl,
      "description":description,
      "comment":comment,
      "time":time,
      "subject":subject,
    };
  }
}