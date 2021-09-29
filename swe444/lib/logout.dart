import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'decisions_tree.dart';
import '../Views/login_page.dart';
import '../Widget/v_feed.dart';

class logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _logout();
  }
}

class _logout extends State<logout> {
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
            child: Text("تسجيل الخروج",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Tajawal', color: const Color(0xff334856))),
            // style: TextButton.styleFrom(
            //   primary: Color(0xff334856),
            //   backgroundColor: const Color(0xdeedd03c),
            //   textStyle: TextStyle(
            //     fontSize: 18,
            //   ),
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50)),
            // ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150.w, 50.h),
              primary: const Color(0xdeedd03c),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DecisionsTree()));
            },
          ),
        ),
      ),
    );
  } //build

  logout_() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DecisionsTree()));
  }
}
