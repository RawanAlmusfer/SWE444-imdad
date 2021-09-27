import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Request {
  // String? documentId;
  String? posted_by;
  String? type;
  int? amount;
  int donated = 0;
  String? description;
  String? title;
  String? mosque_name;
  String? mosque_location;

  Request(
    this.title,
    this.type,
    this.amount,
    this.posted_by,
    this.description,
    this.mosque_name,
    this.mosque_location,
  );



  // formatting for upload to Firebase when creating the request
  Map<String, dynamic> toJson() => {
        'posted_by': posted_by,
        'title': title,
        'type': type,
        'description': description,
        'amount': amount,
        'donated': donated,
        'mosque_name': mosque_name,
        'mosque_location': mosque_location,
      };
}
