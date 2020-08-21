import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Screen/Attendance/Model/AttendanceModel.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';
class AttendanceViewModel extends ChangeNotifier {
  Api _api = Api('Attendance');
  List<AttendanceModel> attendance;
  Future<List<AttendanceModel>> fetchAttendance() async {
    var result = await _api.getDataCollection();
    attendance = result.documents
        .map((doc) => AttendanceModel.fromMap(doc.data, doc.documentID))
        .toList();
    return attendance;
  }

  Stream<QuerySnapshot> fetchAttendanceAsStream() {
    return _api.streamDataCollection();
  }

  Future<AttendanceModel> getAttendanceById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  AttendanceModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeAttendance(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateAttendance(AttendanceModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addAttendance(AttendanceModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }


}
