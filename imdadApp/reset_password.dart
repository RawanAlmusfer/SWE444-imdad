import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'login_page.dart';
import 'decisions_tree.dart';
import 'users_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  static const kYellow = const Color(0xdeedd03c);
  TextEditingController _controllerEmail = TextEditingController();
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('إعادة ضبط كلمة السر', style: TextStyle(color: Color(0xff334856),)),

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DecisionsTree()));
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,
                ),

                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),


                  ],
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async{
                  await  auth.sendPasswordResetEmail(email: _controllerEmail.text)
                        .then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DecisionsTree())));
                  },
                  child: Text(
                    'إعادة ضبط كلمة السر',
                    style: TextStyle(color: Color(0xff334856),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,),
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

                // RaisedButton(
                //     onPressed: () {
                //       isLogin ? login() : createUser();
                //     },
                //     child: Text(isLogin ? "تسجيل الدخول" : "التسجيل")),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
