import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Functions/decisions_tree.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class notification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _notification();
  }
}

class _notification extends State<notification> {
FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xffededed), spreadRadius: 1, blurRadius: 10),
            ],
          ),
          height: 50,
          width: 150,
          child: ElevatedButton(
            child: Text("Test",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Tajawal', color: const Color(0xff334856))),
        
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150.w, 50.h),
              primary: const Color(0xdeedd03c),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              messaging.getToken().then((token){
      FirebaseFirestore.instance.collection('tokens').add({
        'token':token
      });
    });
            },
          ),
        ),
      ),
    );
  } //build


}
