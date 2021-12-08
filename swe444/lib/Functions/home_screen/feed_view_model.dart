import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;

  // late bool? isVSubscribed;
  late List<String> isVSubscribed = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests2;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _requests3;
  User? user = FirebaseAuth.instance.currentUser;
  late List<String> searchResults = [];
  late int length;


  fetchRequests() async {
    var firebase = FirebaseFirestore.instance.collection('requests');
    _requests = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  // fetchRequests2() async {
  //
  //   _requests3 = await FirebaseFirestore.instance.collection('requests')
  //       .doc()
  //       .collection('donations')
  //       .where('uid', isEqualTo: vUser).snapshots();
  //
  //
  //   notifyListeners();
  // }


  get userDocument {
    return FirebaseFirestore.instance.collection("testDonations").doc(user!.uid).get();
  }

 Future<String> checkRequestExistence(DocumentSnapshot  requestId)  async {
   bool isIrequestExsisted=false;
   bool isMrequestExsisted=false;
   String? returnWord='';
   if(requestId['type']=='موارد'){
    final querySnapshot = await FirebaseFirestore
        .instance
        .collection('testDonations')
        .doc(user!.uid)
        .get();
if(querySnapshot.exists){
    final data = querySnapshot.data();

    if (data != null) {
      List requestsIds = data['donatedRequests'];

      isIrequestExsisted = requestsIds.contains(requestId.id);
      if(isIrequestExsisted)
        returnWord ='item';
    } }}


   ////money
   if(requestId['type']=='مبلغ'){
     final querySnapshot = await FirebaseFirestore
         .instance
         .collection('moneyDonations')
         .doc(user!.uid)
         .get();
     if(querySnapshot.exists){
       final data = querySnapshot.data();

       if (data != null) {
         List requestsIds = data['donatedRequests'];

         isMrequestExsisted = requestsIds.contains(requestId.id);
         if(isMrequestExsisted)
           returnWord= 'money';
       } }}




    return returnWord;
  }

  Future<bool> checkRequestExistence2(String? requestId)  async {
    bool isRequestExsisted=false;
    final querySnapshot = await FirebaseFirestore
        .instance
        .collection('moneyDonations')
        .doc(user!.uid)
        .get();
    if(querySnapshot.exists){
      final data = querySnapshot.data();

      if (data != null) {
        List requestsIds = data['donatedRequests'];

        isRequestExsisted = requestsIds.contains(requestId);
      } }

    return isRequestExsisted;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests2 {
    return _requests2;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests3 {
    return _requests3;
  }

  List<String> get getSearchResults {
    return searchResults;
  }

  int getLength() {
    return length;
  }


  Future<void> lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not lunch the url";
    }
  }


  // Future<void> subscribedList() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   var userList = await FirebaseFirestore.instance.collection('users').get();
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .where('role', isEqualTo: "mosqueManager")
  //       .get()
  //       .then((snapshot) {
  //     snapshot.docs.forEach((mosqueManager) {
  //       var isHere =
  //       FirebaseFirestore
  //           .instance
  //           .collection("users")
  //           .doc(mosqueManager.id)
  //           .collection("subscribedVolunteers")
  //           .doc(user?.uid.toString());
  //       if (isHere != null) {
  //         if (!isVSubscribed.contains(mosqueManager.id)) isVSubscribed.add(
  //             mosqueManager.id);
  //       } else {
  //         print("not a fan hehehe:" + mosqueManager.id.toString());
  //       }
  //     });
  //   });
  // }

  Future QueryRequests(String query) async {
    searchResults.clear();

    FirebaseFirestore.instance
        .collection('requests')
        .where('title', isGreaterThanOrEqualTo: query)
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        if (i.current["title"].toString().contains(query)) {
          if ((i.current['type'].toString() == "مبلغ" &&
              i.current['donated'] < i.current['amount']) ||
              (i.current['type'].toString() == "موارد" &&
                  i.current['donated'] < i.current['amount_requested']) ||
              (i.current['type'].toString() == "تنظيم" &&
                  i.current['participants'] < i.current['parts_number'])
          ) {
            String id = i.current.id;
            // print(id);
            if (!searchResults.contains(id)) {
              searchResults.add(id);
            }
            ;
          }
        }
      }
    }).onError((error, stackTrace) => print("error"));

    FirebaseFirestore.instance
        .collection('requests')
        .where('mosque_name', isGreaterThanOrEqualTo: query)
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        if (i.current["mosque_name"].toString().contains(query)) {
          if ((i.current['type'].toString() == "مبلغ" &&
              i.current['donated'] < i.current['amount']) ||
              (i.current['type'].toString() == "موارد" &&
                  i.current['donated'] < i.current['amount_requested']) ||
              (i.current['type'].toString() == "تنظيم" &&
                  i.current['participants'] < i.current['parts_number'])
          ) {
            String id = i.current.id;
            // print(id);
            if (!searchResults.contains(id)) {
              searchResults.add(id);
            }
            ;
          }
        }
      }
    }).onError((error, stackTrace) => print("error"));

    FirebaseFirestore.instance
        .collection('requests')
        .where('description', isGreaterThanOrEqualTo: query)
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        if (i.current["description"].toString().contains(query)) {
          if ((i.current['type'].toString() == "مبلغ" &&
              i.current['donated'] < i.current['amount']) ||
              (i.current['type'].toString() == "موارد" &&
                  i.current['donated'] < i.current['amount_requested']) ||
              (i.current['type'].toString() == "تنظيم" &&
                  i.current['participants'] < i.current['parts_number'])
          ) {
            String id = i.current.id;
            // print(id);
            if (!searchResults.contains(id)) {
              searchResults.add(id);
            }
          }
        }
      }
    }).onError((error, stackTrace) => print("error"));

    notifyListeners();
  }

}
