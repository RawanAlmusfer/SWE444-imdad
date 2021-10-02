import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'login_page.dart';
import 'package:swe444/decisions_tree.dart';
import 'signup_login_screen.dart';
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
        title: Text('إعادة ضبط كلمة السر',    textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff334856),
            fontWeight: FontWeight.w700,
            fontFamily: 'Tajawal',
            fontSize: 24,
          ),),

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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0,top: 70),
                      child: Container(
                          height: 160,
                          width: 160,
                          child: Image.asset('images/logo.png')),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0, top: 115),
                      child: Text(
                        "مرحباً بك في",
                        style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
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
                    cursorColor: const Color(0xdeedd03c),
                    textAlign: TextAlign.right,
                    controller: _controllerEmail,
                    decoration: new InputDecoration(
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: kYellow,
                        ),
                      ),
                      prefixIcon: Icon(Icons.email_outlined,color: const Color(0xff334856),),
                      prefixStyle: TextStyle(
                          fontSize: 18, color: const Color(0xff334856)),
                      hoverColor: const Color(0xff334856),
                      hintText: 'أدخل البريد الالكتروني',
                      labelText: 'البريد الالكتروني',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff334856),
                          fontFamily: 'Tajawal'),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
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
                      .height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async{
                    await  auth.sendPasswordResetEmail(email: _controllerEmail.text)
                        .then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(onSignIn: (User ) { DecisionsTree(); },))));
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
