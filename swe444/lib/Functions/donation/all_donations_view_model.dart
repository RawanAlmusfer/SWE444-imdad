import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllDonation with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;

  // late bool? isVSubscribed;
  // late List<String> myDonations = [];
  Stream<List<String>>? myDonations;
  late int length;

  fetchRequests() async {
    var firebase = FirebaseFirestore.instance.collection('requests');
    _requests = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  usersDonations(String uid) async {
    FirebaseFirestore.instance
        .collection('requests')
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        FirebaseFirestore.instance
            .collection('requests')
            .doc(i.current.id)
            .collection('donations')
            .where('uid', isEqualTo: uid)
            .snapshots()
            .forEach((snapshot) {
          var i = snapshot.docs.iterator;
          while (i.moveNext()) {
            if (i.current["title"].toString().contains(uid)) {
              if ((i.current['type'].toString() == "مبلغ" &&
                      i.current['donated'] < i.current['amount']) ||
                  (i.current['type'].toString() == "موارد" &&
                      i.current['donated'] < i.current['amount_requested']) ||
                  (i.current['type'].toString() == "تنظيم" &&
                      i.current['participants'] < i.current['parts_number'])) {
                String id = i.current.id;
                myDonations!.forEach((list) {
                  if (list.contains(id)) {}
                });
              }
            }
          }
        }).onError((error, stackTrace) => print("error"));
      }
    });

    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }
}
