import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/StudentModel.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';

class StudentViewModel extends ChangeNotifier {
  Api _api = Api('student');
  List<StudentModel> student;
  Future<List<StudentModel>> fetchClass() async {
    var result = await _api.getDataCollection();
    student = result.documents
        .map((doc) => StudentModel.fromMap(doc.data, doc.documentID))
        .toList();
    return student;
  }

  Stream<QuerySnapshot> fetchStudentAsStream() {
    return _api.streamDataCollection();
  }

  Future<StudentModel> getStudentById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  StudentModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeStudent(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateStudent(StudentModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addStudent(StudentModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }
}
