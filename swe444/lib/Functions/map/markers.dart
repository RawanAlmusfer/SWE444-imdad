import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersViewModel {
  // Stream<QuerySnapshot<Map<String, dynamic>>>? _mosques;
  late Set<Marker> _markers = {};

  fetchMosques() async {
    FirebaseFirestore.instance
        .collection('mosques_code')
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        _markers.add(Marker(
          markerId: i.current['name'],
          position: LatLng(i.current['lat'], i.current['long']),
          infoWindow: InfoWindow(title: i.current['name']),
        ));
      }
    }).onError((error, stackTrace) => print("error"));
  }

  Set<Marker> get markers {
    return _markers;
  }

}
