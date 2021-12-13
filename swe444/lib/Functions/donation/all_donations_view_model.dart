import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllDonationVM with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;

  // late bool? isVSubscribed;
  late List<String> userDonations = [];
  Stream<List<String>>? myDonations;
  late int length;

  fetchRequests() async {
    var firebase = FirebaseFirestore.instance.collection('requests');
    _requests = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  Future<List<String>> usersDonations(String uid) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .snapshots()
        .forEach((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var i = snapshot.docs.iterator;
        while (i.moveNext()) {
          String id = i.current.id;
          QueryDocumentSnapshot request = i.current;

          if (FirebaseFirestore.instance
                  .collection('requests')
                  .doc(i.current.id)
                  .collection('donations')
                  .runtimeType !=
              'Null') {

             FirebaseFirestore.instance
                .collection('requests')
                .doc(i.current.id)
                .collection('donations')
                .where('uid', isEqualTo: uid)
                .snapshots()
                .forEach((snapshot) {
              if (snapshot.docs.isNotEmpty) {
                var j = snapshot.docs.iterator;
                while (j.moveNext()) {
                  if (j.current["uid"].toString() == uid) {
                    // String id = j.current.id;
                    if (!userDonations.contains(id)) {
                      print(request['title']);
                      userDonations.add(id);
                    }
                  }
                }
              }
            }).onError((error, stackTrace) =>
                    print("error" + error.toString() + stackTrace.toString()));

            {

               FirebaseFirestore.instance
                  .collection('requests')
                  .doc(i.current.id)
                  .collection('moneyDonations')
                  .where('uid', isEqualTo: uid)
                  .snapshots()
                  .forEach((snapshot) {
                if (snapshot.docs.isNotEmpty) {
                  var j = snapshot.docs.iterator;
                  while (j.moveNext()) {
                    if (j.current["uid"].toString() == uid) {
                      // String id = j.current.id;
                      if (!userDonations.contains(id)) {
                        print(request['title']);
                        userDonations.add(id);
                      }
                    }
                  }
                }
              }).onError((error, stackTrace) => print(
                      "error" + error.toString() + stackTrace.toString()));
            }
          }

          /// item

          //       if (FirebaseFirestore.instance
          //               .collection('requests')
          //               .doc(i.current.id)
          //               .collection('donations')
          //               .runtimeType !=
          //           'Null') {
          //         print("here--------3333");
          //
          //          FirebaseFirestore.instance
          //             .collection('requests')
          //             .doc(i.current.id)
          //             .collection('moneyDonations')
          //             .where('uid', isEqualTo: uid)
          //             .snapshots()
          //             .forEach((snapshot) {
          //           if (snapshot.docs.isNotEmpty) {
          //             var j = snapshot.docs.iterator;
          //             while (j.moveNext()) {
          //               if (j.current["uid"].toString() == uid) {
          //                 // String id = j.current.id;
          //                 if (!userDonations.contains(id)) {
          //                   print(request['title']);
          //                   userDonations.add(id);
          //                 }
          //               }
          //             }
          //           }
          //         }).onError((error, stackTrace) =>
          //                 print("error" + error.toString() + stackTrace.toString()));
          //       }
          //     }
          //   }
        }
      }
    }).onError((error, stackTrace) =>
            print("error" + error.toString() + stackTrace.toString()));

    notifyListeners();
    return userDonations;
  }

  List<String> get donations {
    return userDonations;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }
}
