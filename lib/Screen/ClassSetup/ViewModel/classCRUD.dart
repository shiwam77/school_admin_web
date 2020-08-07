import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';
import '../Model/ClassModel.dart';
class ClassViewModel extends ChangeNotifier {
  Api _api = Api('class');
  List<ClassModel> classes;
  Future<List<ClassModel>> fetchClass() async {
    var result = await _api.getDataCollection();
    classes = result.documents
        .map((doc) => ClassModel.fromMap(doc.data, doc.documentID))
        .toList();
    return classes;
  }

  Stream<QuerySnapshot> fetchClassAsStream() {
    return _api.streamDataCollection();
  }

  Future<ClassModel> getClassById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  ClassModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeClass(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateClass(ClassModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addClass(ClassModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }
}
