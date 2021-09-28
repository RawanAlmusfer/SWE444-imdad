import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'users_screen.dart';
import 'login_form_widget.dart';

//it should be as profile page

class HomePage extends StatelessWidget {
  late final Function(User) onSignOut;

  HomePage({required this.onSignOut});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      //onSignOut(null!);

    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  //Navigator.popUntil(context, ModalRoute.withName("/"));
  //
  //
  // Navigator.of(context, rootNavigator: true).pop(context);

  /*// sign out
  Future logout() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }*/

  /* Future <void> signOut() async {
    await _firebaseAuth.signOut();
  }*/

//signOut();
// onSignOut();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "الرئيسية",
          style: TextStyle(
            color: Color(0xff334856),
          ),
        ),
        backgroundColor: const Color(0xdeedd03c),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color:   Color(0xff334856),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UsersScreen()));
            },
          )
        ],
      ),
      // body: Center(
      //   child: Container(
      //       child: RaisedButton(onPressed: ()
      //       // logout();
      //       // async {
      //       //   await FirebaseAuth.instance.signOut();
      //       //   Navigator.pushReplacement(context,
      //       //       MaterialPageRoute(builder: (context) => UsersScreen()));
      //       // }
      //         // child: Text("تسجيل الخروج"),
      //
      //
      //       )
      //   ),
      // ),
    );
  }
}
