class ClassModel {
  String id;
  String academicYearId;
  String classes;
  ClassModel({this.id, this.classes,this.academicYearId});
  ClassModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
       academicYearId = snapshot['academicYearID'] ?? '',
        classes = snapshot['class'] ?? '';
  toJson() {
    return {
      "class": classes,
      "academicYearID":academicYearId,
    };
  }
}