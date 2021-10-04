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


  // void getAccess() async{
  //   userId = FirebaseAuth.instance.currentUser!.uid;
  //    document = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //
  // }

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    if (mounted) {
      setState(() {
        user = userCred;
      });
    }

  }


  @override
  Widget build(BuildContext context)  {
    if (user == null) {
      return UsersScreen();
    }

    else {
     // var document;
      String userID = user!.uid;
       FirebaseFirestore.instance.collection('users').doc(userID).get().then((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data();
          if (data!['role'] == 'mosqueManager') {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new mmHome()));
          } else  if (data!['role'] == 'volunteer'){
            Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new vHome()));}
        } else {  print('Not Authorized');
Navigator.of(context).push(
new MaterialPageRoute(builder: (context) => UsersScreen()));
}

      });

    } //end outter else

    return UsersScreen();
  }





//else {}
// String userId = await FirebaseAuth.instance.currentUser!.uid;
// var document = await FirebaseFirestore.instance.collection('users').doc(userId).get();
// if (document.exists){
// Map<String, dynamic>? data = document.data();
// if (data!['role'] == 'mosqueManager') {
//
// Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new mmHome()));
// }
// else
// Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new vHome()));
// }
//
// else { print ('Not Authorized');  return UsersScreen();}


// else{
// String userId = await FirebaseAuth.instance.currentUser!.uid;
// var document = await FirebaseFirestore.instance.collection('users').doc(
// userId).get();
// if (document.exists) {
// Map<String, dynamic>? data = document.data();
// if (data!['role'] == 'mosqueManager') {
// Navigator.of(context).push(
// new MaterialPageRoute(builder: (context) => new mmHome()));
// }
// else
// Navigator.of(context).push(
// new MaterialPageRoute(builder: (context) => new vHome()));
// }
//
// else {
// print('Not Authorized');
// Navigator.of(context).push(
// new MaterialPageRoute(builder: (context) => UsersScreen()));
// }}


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
