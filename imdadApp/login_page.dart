import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'singup_login_screen.dart';

class LoginPage extends StatefulWidget {
  final Function(User) onSignIn;

  LoginPage({required this.onSignIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignupLoginScreen()));
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
                new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new TextFormField(
                    showCursor: true,
                    textAlign: TextAlign.right,
                    controller: _controllerEmail,
                    decoration: new InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: kYellow,
                        ),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'أدخل البريد الالكتروني',
                      labelText: 'البريد الالكتروني',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new TextFormField(
                    textAlign: TextAlign.right,
                     controller: _controllerPass,
                    decoration: new InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: kYellow,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: 'أدخل كلمة السر',
                      labelText: 'كلمة السر',
                    ),
                    autocorrect: false,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('',
                       // 'هل نسيت كلمة السر؟',
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                          color: Color(0xff334856),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),

                ElevatedButton(

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
                    onPressed: () {
                      isLogin ? login() : createUser();
                    },
                    child: Text(isLogin ? "تسجيل الدخول" : "التسجيل", style: TextStyle(color: Colors.white, fontSize: 20),)



                ),
                Text(error),
                // RaisedButton(
                //     onPressed: () {
                //       isLogin ? login() : createUser();
                //     },
                //     child: Text(isLogin ? "تسجيل الدخول" : "التسجيل")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text('Temp: Switch sign in/up'))
              ],
            ),
          ),
        ),
      ),
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
