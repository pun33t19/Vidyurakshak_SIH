import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class TasksRepository {
  FirebaseFirestore _firebaseFirestoredb = FirebaseFirestore.instance;
  final data = {
    'description':
        'Immedtiate attention required near sakhini river , the tree has grown past the limit and poses threatto the nearby trnasmission towers.',
    'priority': 'High',
    'status': 'Start',
    'title': 'Immediate check required',
    'location': const GeoPoint(0, 0)
  };
  void addData() async {
    try {
      await _firebaseFirestoredb.collection('Tasks').add(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docList = [];
    try {
      final querySnaps = await _firebaseFirestoredb.collection("Tasks").get();

      docList.addAll(querySnaps.docs);
    } catch (e) {
      print(e.toString());
    }

    return docList;
  }
}
