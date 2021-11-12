import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class FeedViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;
  bool? isVSubscribed = false;
  fetchRequests() async {
    var firebase=  FirebaseFirestore.instance
        .collection('requests');
    _requests =
        firebase.orderBy('uplaod_time', descending: true)
        .snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }


  Future<void> lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not lunch the url";
    }
  }
  Future<bool> isSubscribed(String mID) async {
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
        isVSubscribed = true;
      }
      else {
        print('Document dose not exists on the database');
      isVSubscribed = false;
      }
    });
 print("isVSubscribed is " + isVSubscribed.toString());
  return isVSubscribed as bool;
  }

}
//
// class RequestViewModel {
//   Request _request;
//
//   RequestViewModel({required Request request}) : _request = request;
// }
