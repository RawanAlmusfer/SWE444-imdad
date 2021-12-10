import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationsViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _items;
  User? user = FirebaseAuth.instance.currentUser;
  String? _docID;
  // late List<String> isVSubscribed = [];

  fetchDonations() async {
    _items = FirebaseFirestore.instance
        .collection('requests')
        .doc(_docID)
        .collection("donations")
        .snapshots();

    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get items {
    return _items;
  }

  String? get docID {
    return _docID;
  }

  set setdocID(String? value) {
    if (value != null) {
      _docID = value;
    }
  }
}
