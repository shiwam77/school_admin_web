class AcademicModel {
  String id;
  String year;
  AcademicModel({this.id, this.year});
  AcademicModel.fromMap(Map snapshot,String id) :
        id = id ?? '',
        year = snapshot['year'] ?? '';
  toJson() {
    return {
      "year": year,
    };
  }
}