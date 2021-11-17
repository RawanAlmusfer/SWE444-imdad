import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _requests2;
  late List<String> searchResults = [];

  fetchRequests() async {
    var firebase = FirebaseFirestore.instance.collection('requests');
    _requests = firebase.orderBy('uplaod_time', descending: true).snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests {
    return _requests;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get requests2 {
    return _requests2;
  }

  List<String> get getSearchResults {
    return searchResults;
  }

  Future<int> getLength() async {
    int length = searchResults.length;
    notifyListeners();
    return length;
  }

  Future<void> lunchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not lunch the url";
    }
  }


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
          String id = i.current.id;
          print(id);
          if (!searchResults.contains(id)) searchResults.add(id);
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
          String id = i.current.id;
          print(id);
          if (!searchResults.contains(id)) searchResults.add(id);
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
          String id = i.current.id;
          print(id);
          if (!searchResults.contains(id)) searchResults.add(id);
        }
      }
    }).onError((error, stackTrace) => print("error"));

    notifyListeners();
  }
}

