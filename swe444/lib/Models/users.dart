import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class users {
  // String? documentId;
  String? username;


  users(
      this.username,

      );



  // formatting for upload to Firebase when creating the request
  Map<String, dynamic> toJson() => {
    'username': username,
  };
}