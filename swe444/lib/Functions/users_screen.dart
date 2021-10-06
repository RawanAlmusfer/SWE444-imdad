import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Functions/decisions_tree.dart';
import 'package:swe444/Functions/signup_login_screen.dart';
import 'CustomPageRoute.dart';
import 'login/login_page.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const kYellow = Color(0xdeedd03c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          top: 120.0,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
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
                          .push(CustomPageRoute(child: SignupLoginScreen()));
                    },
                    child: const Text(
                      'تسجيل جديد',
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
                          .push(CustomPageRoute(child: LoginPage(
                        onSignIn: (User) {
                          DecisionsTree();
                        },
                      )));
                    },
                    child: const Text(
                      'تسجيل الدخول',
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
      ),
    );
  }
}
