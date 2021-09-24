import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function(User) onSignIn;

  LoginPage({required this.onSignIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
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
      // widget.onSignIn(userCredential.user);
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
      //widget.onSignIn(userCredential.user);
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
      appBar: AppBar(title: Text("صفحة تسجيل الدخول")),
      body: Column(children: [
        /*RaisedButton(
            onPressed: () {
              loginAno();
            },
            child: Text("Sign in Ano")),*/
        TextFormField(
          textAlign: TextAlign.right,
          controller: _controllerEmail,
          decoration: InputDecoration(
            labelText: "البريد الالكتروني",
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: _controllerPass,
          decoration: InputDecoration(
            labelText: "كلمة السر",
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
        Text(error),
        RaisedButton(
            onPressed: () {
              isLogin ? login() : createUser();
            },
            child: Text(isLogin ? "تسجيل الدخول" : "التسجيل")),
        OutlinedButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text('Switch sign in/up'))
      ]),
    );
  }
}

//signUp

/*

Future<void> login() async {

    try{
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerPass.text);
    print(userCredential.user);
   // widget.onSignIn(userCredential.user);
    //
    }

   on FirebaseAuthException catch (e){

setState(() {
  error = e.toString();
  bool login = true;
});


    }
  }
 */
