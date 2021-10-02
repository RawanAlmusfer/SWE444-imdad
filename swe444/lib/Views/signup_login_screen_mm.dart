import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:swe444/Views/login_page_mm.dart';
import 'login_page.dart';
import 'package:swe444/decisions_tree.dart';
import 'package:swe444/Views/users_screen.dart';
import 'package:swe444/signup.dart';

class mSignupLoginScreen extends StatefulWidget {
  @override
  _SignupLoginScreenState createState() => _SignupLoginScreenState();
}

class _SignupLoginScreenState extends State<mSignupLoginScreen> {
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
      appBar: AppBar(
        bottomOpacity: 30,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UsersScreen()));
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
        iconTheme: IconThemeData(
          // Padding(padding: EdgeInsets.only(right: 20.0)),

          color: Color(0xff334856), //change your color here.
        ),
        backgroundColor: const Color(0xdeedd03c),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                Image.asset('images/logo.png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "مرحباً بك",
                  style: TextStyle(
                    color: Color(0xff334856),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage(onSignIn: (User ) { DecisionsTree(); },)));
                  },
                  child: Text(
                    'تسجيل جديد',
                    style: TextStyle(
                      color: Color(0xff334856),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                    MaterialStateProperty.all(Color(0xdeedd03c)),
                    minimumSize: MaterialStateProperty.all(Size(300, 64)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(onSignIn: (User ) { DecisionsTree(); },)));
                  },
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      color: Color(0xff334856),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                    MaterialStateProperty.all(Color(0xdeedd03c)),
                    minimumSize: MaterialStateProperty.all(Size(300, 64)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
