import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const kYellow = const Color(0xdeedd03c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xdeedd03c),
      ),
      body:

    new Container(

        padding: new EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [

                Image.asset('assets/logo.png',width:50,height:50),


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text("مرحباً بك", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                new Directionality(
                  textDirection: TextDirection.rtl,

                  child: new TextFormField(
                    showCursor: true,
                    textAlign: TextAlign.right,
                    decoration: new InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(color: kYellow, ),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'أدخل البريد الالكتروني',
                      labelText: 'البريد الالكتروني',
                      alignLabelWithHint: true,
                     border: OutlineInputBorder( ),

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
                    decoration: new InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(color: kYellow, ),
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'هل نسيت كلمة السر؟',
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
