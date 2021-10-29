import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/moneyVFeed.dart';

import '../CustomPageRoute.dart';
import '../decisions_tree.dart';
import 'itemsVFeed.dart';

class vhome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _vhome();
  }
}

class _vhome extends State<vhome> {
  var type = [
    Type("التبرع بالمال", "images/money.png", 1),
    Type("items التبرع بال", "images/items.png", 2)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Padding(
        padding: const EdgeInsets.only(top: 130.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (type[index].num == 1) {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: moneyVFeed()));
                } else {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: itemsVFeed()));
                }
              },
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19.0),
                            gradient: LinearGradient(
                              colors: [Color(0xffffffff), Color(0xdef3f1e9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffc6c2c2),
                                blurRadius: 7,
                                offset: Offset(0, 1),
                              ),
                            ]),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 10),
                            child: Image.asset(
                              type[index].image.toString(),
                              height: 100,
                              width: 130,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 50.0, top: 18.0),
                            child: Text(
                              type[index].type.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff334856),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Tajawal',
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  } //build

}

class Type {
  String? type;
  String? image;
  int? num;
  Type(this.type, this.image, this.num);
} //

//
// Container(
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Color(0xffededed), spreadRadius: 1, blurRadius: 10),
// ],
// ),
// height: 50,
// width: 150,
// child: ElevatedButton(
// child: Text("تسجيل الخروج",
// textAlign: TextAlign.center,
// style: TextStyle(
// fontFamily: 'Tajawal', color: const Color(0xff334856))),
// // style: TextButton.styleFrom(
//   primary: Color(0xff334856),
//   backgroundColor: const Color(0xdeedd03c),
//   textStyle: TextStyle(
//     fontSize: 18,
//   ),
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(50)),
// ),
// style: ElevatedButton.styleFrom(
// minimumSize: Size(150.w, 50.h),
// primary: const Color(0xdeedd03c),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(50),
// ),
// ),
// onPressed: () {
// Navigator.of(context)
//     .push(CustomPageRoute(child: VolunteerFeed()));
// },
// ),
// ),
