import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:swe444/Models/request.dart';

class FeedViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;

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
}
//
// class RequestViewModel {
//   Request _request;
//
//   RequestViewModel({required Request request}) : _request = request;
// }
