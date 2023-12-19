import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<List<Marker>> fetchMarkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestoredb.collection('Tasks').get();

      final List<Marker> markerList = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        final GeoPoint latLng = doc.get('location');
        final String priority = doc.get('priority');

        if (latLng != null) {
          markerList.add(
            Marker(
              markerId: MarkerId('marker_${markerList.length + 1}'),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(
                title: 'Corridor ${markerList.length + 1}',
                snippet: priority,
              ),
              icon: getMarkerIcon(priority),
            ),
          );
        }
      }

      return markerList;
    } catch (e) {
      // Handle the error
      print("Error fetching marker data: $e");
      return [];
    }
  }

  BitmapDescriptor getMarkerIcon(String priority) {
    if (priority == 'high') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else if (priority == 'medium') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }
  }
}
