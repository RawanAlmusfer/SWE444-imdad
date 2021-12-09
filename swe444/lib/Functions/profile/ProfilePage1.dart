import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter/gestures.dart';
import 'package:swe444/Functions/home_screen/v_view_allDonations.dart';
>>>>>>> Stashed changes

import 'edit_profile_view.dart';
import 'edit_vprofile_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  String _title = "الملف الشخصي";

  final auth = FirebaseAuth.instance;

  String _userFirstName = 'User NAme';
  String _userLastName = 'Last Name';
  late String _userEmail;
  String _userPhone = '05XXX';
  String role = '';
  String? mosqueName;
  String? mosqueCode;
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
          role = value.get('role');
          if (isVolunteer()) {
            document = value;
            if (value.data()!.containsKey('first_name') &&
                value.data()!.containsKey('last_name') &&
                value.data()!.containsKey('phone_number')) {
              _userFirstName = value.get('first_name');
              _userLastName = value.get('last_name');
              _userPhone = value.get('phone_number').toString();
            }
          } else {
            document = value;
            if (value.data()!.containsKey('mosque_name') &&
                value.data()!.containsKey('mosque_code') &&
                value.data()!.containsKey('phone_number')) {
              mosqueName = value.get('mosque_name');
              mosqueCode = value.get('mosque_code');
              _userPhone = value.get('phone_number').toString();
            }
          }
          print(value.data().toString());
        }
      });
    });
  }

  @override
  void initState() {
    if (auth.currentUser != null) {
      _userEmail = user()!.email ?? '';
      getUserInformation();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bold = TextStyle(fontWeight: FontWeight.bold);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffededed),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.0,
                  1.0
                ],
                    colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).accentColor.withOpacity(0.5),
                ])),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "FlutterTutorial.Net",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.screen_lock_landscape_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Splash Screen',
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                //  title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                //  ),
                //   onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                //   },
                //  ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt_1,
                      size: _drawerIconSize,
                      color: Theme.of(context).accentColor),
                  title: Text(
                    'Registration Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {},
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.password_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Forgot Password Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //   Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_user_sharp,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Verification Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    //  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
<<<<<<< Updated upstream
              //  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
=======
              //  build2(),

>>>>>>> Stashed changes
              Container(
                //width: 250, // to wrap the text in multiline

                alignment: Alignment.centerRight,

                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
<<<<<<< Updated upstream
                    //Positioned.directional(textDirection: TextDirection.rtl, child: ,),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 20, top: 40),
                      decoration: BoxDecoration(
=======
                    // build3(),
                    //Positioned.directional(textDirection: TextDirection.rtl, child: ,),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: new IconButton(
                        icon: new Icon(
                          Icons.spa,
                          size: 50,
                          color: const Color(0xff334856),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => vAllDonations()));
                        },
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        'تبرعاتي',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Tajawal',
                            color: Color(0xff334856),
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(

>>>>>>> Stashed changes
                          // borderRadius: BorderRadius.circular(100),
                          // border: Border.all(width: 5, color: Colors.white),
                          // color: Colors.white,
                          ),
                      child: isVolunteer()
                          ? Icon(
                              Icons.person,
                              size: 80,
                              color: const Color(0xdeedd03c),
                            )
                          : Container(
                              height: 60,
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SvgPicture.string(
                                  mosqueImage,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    // SizedBox(
                    //   height: 1,
                    // ),
                    // Text(isVolunteer()?  "${_userFirstName} ${_userLastName}": "${mosqueName} ${mosqueCode}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    Text(
                      isVolunteer()
                          ? "${_userFirstName} ${_userLastName}"
                          : "${mosqueName} ",
                      style: TextStyle(
                        fontSize: 22,
                        //  fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            //
                            alignment: Alignment.topRight,
                            child: Text(
                              isVolunteer()
                                  ? 'معلومات المتطوع'
                                  : 'معلومات المسجد',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Tajawal',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topRight,

                              //   padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topRight,
                                      ),
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            leading: Icon(isVolunteer()
                                                ? Icons.person
                                                : Icons.account_balance),
                                            title: Text(
                                              isVolunteer()
                                                  ? "الاسم الاول "
                                                  : "اسم المسجد",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${isVolunteer() ? _userFirstName : mosqueName}",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                          ),

                                          ListTile(
                                              leading: Icon(isVolunteer()
                                                  ? Icons.person
                                                  : Icons.shield),
                                              title: Text(
                                                isVolunteer()
                                                    ? "الاسم الاخير "
                                                    : " كود المسجد",
                                                // style: bold,
                                              ),
                                              subtitle: Text(
                                                "${isVolunteer() ? _userLastName : mosqueCode}",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                ),
                                              )),
                                          // ListTile(
                                          //  contentPadding: EdgeInsets.symmetric(
                                          //      horizontal: 12, vertical: 4),
                                          //  leading: Icon(Icons.my_location),
                                          //  title: Text("موقع المسجد"),
                                          //   subtitle: Text("USA"),
                                          // ),
                                          ListTile(
                                            title: Text(
                                              "البريد الالكتروني",
                                              //  style: bold,
                                            ),
                                            subtitle: Text(
                                              "${_userEmail}",
                                              style: TextStyle(
                                                  fontFamily: 'Tajawal'),
                                            ),
                                            leading: Icon(Icons.mail),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.phone,
                                            ),
                                            title: Text(
                                              "رقم الجوال",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${_userPhone}",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          ///
                          if (role == "volunteer")
                            ElevatedButton(
                              child: Text("تعديل الملف الشخصي",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      color: const Color(0xff334856))),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
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

                          if (role == "mosqueManager")
                            ElevatedButton(
                              child: Text("تعديل ملف المسجد",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      color: const Color(0xff334856))),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                primary: const Color(0xdeedd03c),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile(document: document)));
                              },
                            ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          ///
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  } //QWEqwerty123@

  bool isVolunteer() => role == 'volunteer';
<<<<<<< Updated upstream
=======

  // Widget build3() {
  //   return Scaffold(
  //     drawer: NavigationDrawerWidget(),
  //   );
  // }

  Widget build2() {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(
              text: 'تبرعاتي',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: const Color(0xff334856),
                fontSize: 20.0,
                fontFamily: 'Tajawal',
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Terms of Service"');
                }),
        ],
      ),
    );
  }
>>>>>>> Stashed changes
}

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
