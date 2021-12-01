import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersViewModel {
  // Stream<QuerySnapshot<Map<String, dynamic>>>? _mosques;
  late Set<Marker> markers = {};

  Future<Set<Marker>> fetchMosques() async {
    FirebaseFirestore.instance
        .collection('mosques_code')
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        markers.add(Marker(
          markerId: MarkerId(i.current['name']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          position: LatLng(i.current['lat'], i.current['long']),
          infoWindow: InfoWindow(title: i.current['name']),
        ));
        // print('here!!!!!!!!!!!!');
      }
    }).onError((error, stackTrace) => print("error" + error.toString()));
    return markers;
  }

  // Set<Marker> get markers {
  //   return _markers;
  // }

}
