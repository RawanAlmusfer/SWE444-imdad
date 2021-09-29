import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Views/mm_home_view.dart';
//import 'singup_login_screen.dart';
//import 'reset_password.dart';

class SignUpPage extends StatefulWidget {
  final Function(User) onSignIn;

  const SignUpPage({required this.onSignIn});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPass2 = TextEditingController();
  TextEditingController mosqueName = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController mosqueLocation = TextEditingController();
  TextEditingController mosqueCode = TextEditingController();

  static const kYellow = const Color(0xdeedd03c);
  String error = "";
  bool isLogin = true;

  //const LoginPage ({required Key key, required this.onSignInAno}) : super(key: key);
  /*Future<void> loginAno() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print(userCredential.user);
    //User? user2= userCredential.user;
    widget.onSignIn(userCredential.user);
    //Can't record in the database if line above is hided
  } */

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPass.text);
      print(userCredential.user);
      widget.onSignIn(userCredential.user!);
      //
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPass.text);
      print(userCredential.user);
      widget.onSignIn(userCredential.user!);
      //
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.toString();
        // bool login = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "التسجيل",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff334856),
            fontWeight: FontWeight.w700,
            fontFamily: 'Tajawal',
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xdeedd03c),
        bottomOpacity: 30,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => mmHome()));
              },
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff334856),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                          height: 160,
                          width: 160,
                          child: Image.asset('images/logo.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 55),
                      child: Text(
                        "مرحباً بك في",
                        style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: _controllerEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        hintText: 'أدخل البريد الالكتروني',
                        labelText: 'البريد الالكتروني',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        // hoverColor: const Color(0xff334856),
                      ),
                      autocorrect: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: _controllerPass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل كلمة السر',
                        labelText: 'كلمة السر',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: _controllerPass2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل كلمة السر مره اخرى',
                        labelText: 'تاكيد كلمة السر',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: mosqueName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.account_balance,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل اسم المسجد',
                        labelText: 'اسم المسجد',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),

                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      maxLength: 10,
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: phoneNum,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل رقم الجوال',
                        labelText: 'رقم الجوال',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      // style:
                      //     TextStyle(fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: mosqueLocation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل رابط موقع المسجد',
                        labelText: 'موقع المسجد',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: 330,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      // style:
                      //     TextStyle(fontSize: 18, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      controller: mosqueCode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.shield,
                          color: const Color(0xff334856),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        hintText: 'أدخل كود المسجد',
                        labelText: 'كود المسجد',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                      ),
                      autocorrect: false,
                      obscureText: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180.w, 50.h),
                      primary: const Color(0xdeedd03c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      //  isLogin ? login() : createUser();
                    },
                    child: Text(
                      "التسجيل",
                      style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 20,
                          fontFamily: 'Tajawal'),
                    )),
                Text(error),
                // RaisedButton(
                //     onPressed: () {
                //       isLogin ? login() : createUser();
                //     },
                //     child: Text(isLogin ? "تسجيل الدخول" : "التسجيل")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
