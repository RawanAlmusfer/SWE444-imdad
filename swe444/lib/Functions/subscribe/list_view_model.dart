import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _mosques;
  User? user = FirebaseAuth.instance.currentUser;
  // late bool? isVSubscribed;
  // late List<String> isVSubscribed = [];

  fetchMosques() async {
    _mosques = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid.toString())
        .collection("subscribedMosqueManager")
        .snapshots();
    // _mosques = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get mosques {
    return _mosques;
  }

  // List<String> get getIsVSubscribed {
  //   print("in getIsVSubscribed FVM");
  //   return isVSubscribed;
  // }

}
