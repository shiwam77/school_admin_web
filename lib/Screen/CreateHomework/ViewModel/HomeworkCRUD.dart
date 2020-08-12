import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_admin_web/Screen/CreateHomework/Model/homeworkModel.dart';
import 'package:school_admin_web/Service/FirebaseApi.dart';

class HomeWorkViewModel extends ChangeNotifier{
  Api _api = Api('homework');
  List<HomeworkModel> homeWork;
  Future<List<HomeworkModel>> fetchHomework() async {
    var result = await _api.getDataCollection();
    homeWork = result.documents
        .map((doc) => HomeworkModel.fromMap(doc.data, doc.documentID))
        .toList();
    return homeWork;
  }

  Stream<QuerySnapshot> fetchHomeworkAsStream() {
    return _api.streamDataCollection();
  }

  Future<HomeworkModel> getHomeworkById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  HomeworkModel.fromMap(doc.data, doc.documentID) ;
  }


  Future removeHomework(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateHomework(HomeworkModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addHomework(HomeworkModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;

  }
}