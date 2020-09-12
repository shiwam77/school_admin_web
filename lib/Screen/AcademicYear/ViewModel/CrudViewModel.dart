import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Locater.dart';
import 'package:school_admin_web/Screen/AcademicYear/Model/AcademicYearModel.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';



class AcademicYearViewModel extends ChangeNotifier {
  Api _api = classLocator<Api>();
  List<AcademicModel> years;
  Future<List<AcademicModel>> fetchYear() async {
    var result = await _api.getDataCollection();
    years = result.documents
        .map((doc) => AcademicModel.fromMap(doc.data, doc.documentID))
        .toList();
    return years;
  }

  Stream<QuerySnapshot> fetchYearAsStream() {
    return _api.streamDataCollection();
  }

  Future<AcademicModel> getYearById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  AcademicModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeYear(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateYear(AcademicModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addYear(AcademicModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }


}
