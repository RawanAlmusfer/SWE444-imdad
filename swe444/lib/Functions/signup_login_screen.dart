import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:swe444/Functions/signup/signup.dart';
import 'package:swe444/Functions/users_screen.dart';
import 'CustomPageRoute.dart';
import 'signup/signup_v.dart';
import 'package:swe444/Functions/decisions_tree.dart';

class SignupLoginScreen extends StatefulWidget {
  @override
  _SignupLoginScreenState createState() => _SignupLoginScreenState();
}

class _SignupLoginScreenState extends State<SignupLoginScreen> {
  // User? user = FirebaseAuth.instance.currentUser;
  static const kYellow = const Color(0xdeedd03c);

  // onRefresh(userCred) {
  //   setState(() {
  //     // User user = userCred;
  //     user = userCred;
  //   });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 0,
                left: 290,
                top: 45,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UsersScreen()));
                },
                child: Icon(
                  Icons.keyboard_backspace_rounded,
                  textDirection: TextDirection.rtl,
                  size: 30,
                  color: Color(0xff334856),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 35,
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    children: [
                      Image.asset('images/logo.png'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Text(
                        "مرحباً بك",
                        style: TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'Tajawal',
                            color: Color(0xff334856),
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Wrap(
                      //       crossAxisAlignment: WrapCrossAlignment.center,
                      //     ),
                      //   ],
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(CustomPageRoute(child: VSignUpPage(
                            onSignIn: (User) {
                              DecisionsTree();
                            },
                          )));
                        },
                        child: const Text(
                          'متطوع',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Tajawal',
                              color: Color(0xff334856),
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 64),
                          primary: kYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(CustomPageRoute(child: SignUpPage(
                            onSignIn: (User) {
                              DecisionsTree();
                            },
                          )));
                        },
                        child: const Text(
                          'مدير المسجد',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Tajawal',
                              color: Color(0xff334856),
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 64),
                          primary: kYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
