import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swe444/signup.dart';
import 'Views/login_page.dart';
import 'Views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe444/Views/mm_home_view.dart';

import 'Views/signup_login_screen.dart';
import 'Views/users_screen.dart';
import 'Views/v_home_view.dart';

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
 build(BuildContext context) async {
    if (user == null) {
      return UsersScreen();}

else {

      String userId = (await FirebaseAuth.instance.currentUser!).uid;
    var document =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();


    // if (document.data['role'] == 'mosqueManager')
    if (document.exists){
      Map<String, dynamic>? data = document.data();
      if (data!['role'] == 'mosqueManager') {

        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new mmHome()));
      }
      else
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new vHome()));
    }

    else { print ('Not Authorized');  return UsersScreen();}}

   return UsersScreen();



// if (user.){
//   return mmHome();}

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
