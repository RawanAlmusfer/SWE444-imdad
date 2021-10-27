import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Request1 {
  // String? documentId;
  String? email;
  String? passward;






  // formatting for upload to Firebase when creating the request
  Map<String, dynamic> toJson() => {
    'email': email,
    'passward': passward,

  };
}
