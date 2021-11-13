import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class FeedViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;
  // late bool? isVSubscribed;
  late List<String> isVSubscribed = [];
  fetchRequests() async {
    var firebase = FirebaseFirestore.instance.collection('requests');
    _requests = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }

  List<String> get getIsVSubscribed {
    print("in getIsVSubscribed FVM");
    return isVSubscribed;
  }

  Future<void> lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not lunch the url";
    }
  }

  Future<void> subscribedList() async {
    User? user = FirebaseAuth.instance.currentUser;

    var userList = await FirebaseFirestore.instance.collection('users').get();
    String userID = user!.uid;
    print("user ID in subscribedList " + userID);
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: "mosqueManager")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((mosqueManager) {
        var isHere = FirebaseFirestore.instance
            .collection("users")
            .doc(mosqueManager.id)
            .collection("subscribedVolunteers")
            .doc(userID)
            .get()
            .then((value) {
          if (!isVSubscribed.contains(mosqueManager.id)) {
            isVSubscribed.add(mosqueManager.id);
            print("This mosque added :" + mosqueManager.id.toString());
          } else {
            print("Already exists" + mosqueManager.id.toString());
          }
        });
        // if () {
        //   if (!isVSubscribed.contains(mosqueManager.id))
        //     isVSubscribed.add(mosqueManager.id);
        //   print(isVSubscribed[0].toString());
        // } else {
        //   print("not a fan hehehe:" + mosqueManager.id.toString());
        // }
      });
    });
    print("in subscribedList FVM");
    print(isVSubscribed.length.toString());
    notifyListeners();
    print("all clear here in subscribedList FVM");
  }

  Future<void> isSubscribed(String mID) async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(mID)
        .collection("subscribedVolunteers")
        .doc(user?.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        print(user?.uid.toString());
        print('Document exists on the database');
        //isVSubscribed = true;
      } else {
        print('Document dose not exists on the database');
        //isVSubscribed = false;
      }
    });
    //print("isVSubscribed is " + isVSubscribed.toString());
    //notifyListeners();
    // return isVSubscribed as bool;
  }
}
//
// class RequestViewModel {
//   Request _request;
//
//   RequestViewModel({required Request request}) : _request = request;
// }
