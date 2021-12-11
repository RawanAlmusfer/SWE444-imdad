import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_vprofile_view.dart';

class VolunteerProfile extends StatefulWidget {
  const VolunteerProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return volunteerProfile();
  }
}

class volunteerProfile extends State<VolunteerProfile> {
  final auth = FirebaseAuth.instance;

  String firstName = '';
  String lastName = '';
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
          if (value.data()!.containsKey('first_name') &&
              value.data()!.containsKey('last_name') &&
              value.data()!.containsKey('phone_number')) {
            firstName = value.get('first_name');
            lastName = value.get('last_name');
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

  @override
  Widget build(BuildContext context) {
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(auth.currentUser?.uid)
    //     .get();

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30),
                  child: Container(
                    height: 400,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "متطوع",
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
                                        firstName + " " + lastName,
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
                                      Icons.person,
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
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditVProfile(document: document)));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
