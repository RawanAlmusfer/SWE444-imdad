import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe444/mm_home_view.dart';

class DecisionsTree extends StatefulWidget {
  @override
  _DecisionsTreeState createState() => _DecisionsTreeState();
}

class _DecisionsTreeState extends State<DecisionsTree> {
  //const user = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      // User user = userCred;
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage(
        onSignIn: (userCred) => onRefresh(userCred),
      );
    }

    return mmHome();

    /*if (user) {
      // user is signed in, show user data
      return HomePage();
    }
    else {
      // user is signed out, show sign-in form


      return LoginPage(
        onSignIn: (userCred) => onRefresh(userCred),
      );*/
  }
}
