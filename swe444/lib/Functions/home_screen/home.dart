import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/moneyVFeed.dart';

import '../CustomPageRoute.dart';
import '../decisions_tree.dart';
import 'eventsVFeed.dart';
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
    Type(" التبرع بالموارد", "images/items.png", 2),
    Type("تنظيم المسجد", "images/events.png", 3)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: type.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (type[index].num == 1) {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: moneyVFeed()));
                } else if (type[index].num == 2) {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: itemsVFeed()));
                } else {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: eventsVFeed()));
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
