import 'package:flutter/cupertino.dart';

class Year {
  String id;
  String year;
  Year({this.id, this.year});
}

class ListOfYear {
  List<Year> getYear = [
    Year(id: UniqueKey().toString(), year: '2013'),
    Year(id: UniqueKey().toString(), year: '2014'),
    Year(id: UniqueKey().toString(), year: '2015'),
    Year(id: UniqueKey().toString(), year: '2016'),
    Year(id: UniqueKey().toString(), year: '2017'),
    Year(id: UniqueKey().toString(), year: '2018'),
    Year(id: UniqueKey().toString(), year: '2019'),
    Year(id: UniqueKey().toString(), year: '2020'),
  ];
}
