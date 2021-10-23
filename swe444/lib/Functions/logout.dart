import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'decisions_tree.dart';

class logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _logout();
  }
}

class _logout extends State<logout> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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

        style: ElevatedButton.styleFrom(
          minimumSize: Size(150.w, 50.h),
          primary: const Color(0xdeedd03c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          showDialog(
              builder: (ctxt) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.only(
                        right: 20.w, top: 20.h, bottom: 10.h),
                    title: Text(

                      "تسجيل الخروج",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xdeedd03c),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "هل أنت متأكد من تسجيل الخروج؟",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontFamily: "Tajawal"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              child: const Text(
                                "إلغاء",
                                style: TextStyle(
                                    color: const Color(0xdeedd03c),
                                    fontFamily: "Tajawal"),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xdeffffff)),
                                  elevation:
                                      MaterialStateProperty.all<double>(0)),
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                "تأكيد",
                                style: TextStyle(fontFamily: "Tajawal"),
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DecisionsTree()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xdeedd03c))),
                            )
                          ],
                        ),
                      ],
                    ));
              },
              context: context);
        },
      ),
    );
  } //build

  logout_() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DecisionsTree()));
  }
}
//
// onPressed: () async {
// await FirebaseAuth.instance.signOut();
// Navigator.pushReplacement(context,
// MaterialPageRoute(builder: (context) => DecisionsTree()));
// },
