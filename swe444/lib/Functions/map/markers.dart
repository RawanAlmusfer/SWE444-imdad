import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Functions/profile/viewMosqueProfile.dart';

import '../CustomPageRoute.dart';

class MarkersViewModel {
  // Stream<QuerySnapshot<Map<String, dynamic>>>? _mosques;
  late Set<Marker> markers = {};

  Future<Set<Marker>> fetchMosques(BuildContext context) async {
    FirebaseFirestore.instance
        .collection('mosques_code')
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        String name = i.current['name'].toString();
        String id = i.current.id;

        markers.add(Marker(
          markerId: MarkerId(i.current['name']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          position: LatLng(i.current['lat'], i.current['long']),
          infoWindow: InfoWindow(
            title: i.current['name'],
                onTap:() {
              callProfile(name,id, context );
            }
          ),
        ));
        // print('here!!!!!!!!!!!!');
      }
    }).onError((error, stackTrace) => print("error" + error.toString()));
    return markers;
  }

  callProfile(String name, String ID, BuildContext context) async {
    String? id;

    await FirebaseFirestore.instance
        .collection('users')
        .where('mosque_name', isEqualTo: name)
        .get()
        .then((value) {
      var mosque = value.docs.first;
      id = mosque.id;
    }).catchError((error, stackTrace) => print("error" + error.toString()));

    if (id != null) {
      var followers = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection("subscribedVolunteers")
          .get();
      bool flag = await isSubscribed(id.toString());
      String v = followers.docs.length.toString();
      String r = await countNumOfRequests(id!);
      Navigator.of(context).push(CustomPageRoute(
          child: MosqueMangerProfile(
        isSubscribed: flag,
        numOfVolunteers: v,
        numOfRequests: r,
        MosqueID: id!,
        MosqueName: name,
      )));
    }
  }

  Future<String> countNumOfRequests(String mmId) async {
    var requests =
        await FirebaseFirestore.instance.collection('requests').get();
    var numOfR = 0;
    var requestDocs = requests.docs;

    // loop over each item request
    for (var doc in requestDocs) {
      var requestData = doc.data();
      if (requestData['posted_by'] == mmId) {
        numOfR = numOfR + 1;
      }
    }

    return numOfR.toString();
  }

  Future<bool> isSubscribed(String mID) async {
    User? user = FirebaseAuth.instance.currentUser;
    var subscribedMosques = [];

    var uesrDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid.toString())
        .collection("subscribedMosqueManager")
        .get();

    var docs = uesrDoc.docs;
    //var length = uesrDoc.docs.length;

    for (var Doc in docs) {
      if (!subscribedMosques.contains(Doc.id)) {
        subscribedMosques.add(Doc.id);
      }
    }

    if (subscribedMosques.contains(mID)) {
      return true;
    }
    return false;
  }

// Set<Marker> get markers {
  //   return _markers;
  // }

}
