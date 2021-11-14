
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Subscription  with ChangeNotifier{


   addToMmDoc(String vId, String mmId) async {
     //Map<String, dynamic>? data = vId as Map<String, dynamic>?;
     await FirebaseFirestore.instance
         .collection('users')
         .doc(mmId)
         .collection("subscribedVolunteers")
         .add({'uid':vId}).then((_) => print('تمت إضافة المتطوع لقائمة المشتركين'))
         .catchError((error) => print('لم تتم إضافة المتطوع لقائمة المشتركين:$error'));
//let doc uid same this v
}


  deleteFromMmDoc(String vId, String mmId) async {
     //Map<String, dynamic>? data = vId as Map<String, dynamic>?;


     int? deleted=0;
     await FirebaseFirestore.instance
         .collection('users')
         .doc(mmId)
         .collection("subscribedVolunteers").doc(vId)
         .delete().then((_) {
   deleted=1;
           print('تمت إزالة المتطوع من قائمة المشتركين');})
         .catchError((error) => print('لم إزالة المتطوع من قائمة المشتركين:$error'));

     if(deleted==1)
     return true;
     else return false;

   }

 checkIfVExists(String vId, String mmId) async {
  // var document = await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(vId)
  //     .get();




  await FirebaseFirestore.instance
      .collection('users')
      .doc(mmId)
      .collection("subscribedVolunteers")
      .doc(vId)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      if (documentSnapshot != null)
      return true;
    else  return false;
  }

  });
  // it will not reach there, yet no result
  return false;

  // if (document.exists) {
  //   if (document != null)
  //   return true;
  // else  return false;
  // }
  // else return false;

}}














