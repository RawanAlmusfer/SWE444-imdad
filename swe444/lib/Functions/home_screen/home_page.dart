import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//it should be as profile page

class HomePage extends StatelessWidget {
  late final Function(User) onSignOut;

  HomePage({required this.onSignOut});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    onSignOut(null!);
    //Navigator.popUntil(context, ModalRoute.withName("/"));
    //
    //
    // Navigator.of(context, rootNavigator: true).pop(context);
  }

  /* Future <void> signOut() async {
    await _firebaseAuth.signOut();
  }*/

//signOut();
// onSignOut();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الرئيسية")),
      body: Center(
        child: Container(
            child: RaisedButton(
          onPressed: () {
            logout();
          },
          child: Text("تسجيل الخروج "),
        )),
      ),
    );
  }
}
