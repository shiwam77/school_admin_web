import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Screen/ClassSetup/Model/SubjectModel.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';
import '../Model/ClassModel.dart';
class SubjectViewModel extends ChangeNotifier {
  Api _api = Api('subject');
  List<SubjectModel> subjects;
  Future<List<SubjectModel>> fetchClass() async {
    var result = await _api.getDataCollection();
    subjects = result.documents
        .map((doc) => SubjectModel.fromMap(doc.data, doc.documentID))
        .toList();
    return subjects;
  }

  Stream<QuerySnapshot> fetchSubjectAsStream() {
    return _api.streamDataCollection();
  }

  Future<SubjectModel> getSubjectsById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  SubjectModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeSubject(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateSubject(SubjectModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addSubject(SubjectModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }
}
