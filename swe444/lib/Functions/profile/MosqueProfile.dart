import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MosqueProfile extends StatefulWidget {
  const MosqueProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return mosqueProfile();
  }
}

class mosqueProfile extends State<MosqueProfile> {
  final auth = FirebaseAuth.instance;

  String name = '';
  String code = '';
  late String email = '';
  String phone = '';
  late DocumentSnapshot document;

  User? user() {
    return auth.currentUser;
  }

  getUserInformation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        if (value.exists) {
          document = value;
          if (value.data()!.containsKey('mosque_name') &&
              value.data()!.containsKey('mosque_code') &&
              value.data()!.containsKey('phone_number')) {
            name = value.get('mosque_name');
            code = value.get('mosque_code');
            phone = value.get('phone_number').toString();
          }
          print(value.data().toString());
        }
      });
    });
  }

  @override
  void initState() {
    if (auth.currentUser != null) {
      email = user()!.email ?? '';
      getUserInformation();
    }
    super.initState();
  }

// Mosque code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 100.0, bottom: 0, left: 35, right: 35),
            child: Container(
              height: 440,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "مدير المسجد",
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff334856)),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 230,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                    color: const Color(0xff334856),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, bottom: 8),
                              child: Container(
                                height: 21,
                                width: 26,
                                child: SvgPicture.string(
                                  mosqueImage,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              //  Icon(
                              //   Icons.person,
                              //   //size: 100,
                              //   color: const Color(0xdeedd03c),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                        endIndent: 30,
                        indent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 230,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  email,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                    color: const Color(0xff334856),
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, bottom: 8),
                              child: Icon(
                                Icons.mail,
                                //size: 100,
                                color: const Color(0xdeedd03c),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                        endIndent: 30,
                        indent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 230,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "0" + phone,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                    color: const Color(0xff334856),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, bottom: 8),
                              child: Icon(
                                Icons.phone,
                                //size: 100,
                                color: const Color(0xdeedd03c),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                        endIndent: 30,
                        indent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 230,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  code,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 18,
                                    color: const Color(0xff334856),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, bottom: 8),
                              child: Icon(
                                Icons.shield,
                                //size: 100,
                                color: const Color(0xdeedd03c),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                        endIndent: 30,
                        indent: 30,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                        child: Text("تعديل",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: const Color(0xff334856))),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 35),
                          primary: const Color(0xdeedd03c),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
