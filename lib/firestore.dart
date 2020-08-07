import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class firestoreEg extends StatefulWidget {
  @override
  _firestoreEgState createState() => _firestoreEgState();
}

class _firestoreEgState extends State<firestoreEg> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('AcademicYear').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Center(child: new Text('Error: ${snapshot.error}'));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return
                Center(child: Text('Loading...'));
              default:
                return Material(
                  child: new ListView(
                    scrollDirection: Axis.vertical,
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new ListTile(
                        title: new Text(document['year']),
                      );
                    }).toList(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
