import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';

import 'package:swe444/screens//home_screen.dart';
import'package:swe444/models/registeration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:firebase_database/firebase_database.dart';



//project go ahead

class SignupScreen extends StatefulWidget {

  SignupScreen.ensureInitialized();
  const SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();

}


class _SignupScreenState extends State<SignupScreen> {
  final textcontroller = TextEditingController();
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  //FirebaseFirestore Firestore = FirebaseFirestore.instance;
  //FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  final databaseRef = FirebaseDatabase.instance.reference(); //database reference object

  void addData(String data) {
    databaseRef.push().set({'name': data, 'comment': 'A good season'});
  }

  void printFirebase(){
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _key = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String? username;



  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernamecontroller =  TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  @override
  void dispose()
  {


    _emailcontroller.dispose();

    _passwordController.dispose();



    super.dispose();
  }
  //here


  Map<String, String> _authData = {
    'email': '',

    'password': ''
  };

  String? get passward => null;
  String? get email => null;

  get data => null;

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )
    );
  }

  Future<void> _submit() async
  {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email'] as String,
          _authData['password'] as String


      );
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("صفحة تسجيل الدخول"),
        backgroundColor: const Color(0xdeedd03c),),
      body: Stack(
        children: <Widget>[

          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 300,
                width: 500,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email


                        TextFormField(

                          textAlign: TextAlign.right,

                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            labelText: "البريد الالكتروني",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              if (!value!.contains('@')) {
                                return 'invalid email';
                              }
                              return null;
                            };
                          },
                          onSaved: (value) {
                            _authData['email'] = value!;
                          },

                        ),

                        //password
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          textAlign: TextAlign.right,

                          decoration: InputDecoration(
                            labelText: "كلمة السر",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              if (value!.length <= 5) {
                                return 'invalid password';
                              }
                              return null;
                            };
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.right,

                            decoration: InputDecoration(
                              labelText: "تأكيد كلمةالسر ",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                if (value == _passwordController.text) {
                                  return 'invalid password';
                                }
                                return null;
                              };
                              onSaved:
                                  (value) {

                              };
                            }
                        ),
                        TextFormField(
                            controller: textcontroller,
                            textAlign: TextAlign.right,

                            decoration: InputDecoration(
                              labelText: "الاسم الاول ",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            onSaved:
                                (value) {

                            },
                            onChanged: (_val) {
                              username = _val;
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'invalid ';
                              };
                            }
                        ),

                        SizedBox(
                          height: 30,
                        ),


                        // RaisedButton(
                        //  child:
                        //  Text:'Submit'
                        // ),
                        //  onPressed: () {
//

                        //_submit();
                        // },

                        // shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(30),
                        // ),
                        // color: Colors.blue,
                        //textColor: Colors.white,
                        //  )
                        //here old
                        RaisedButton(
                          child: Text('Sign Up'),
                          onPressed: () {
                            addData(textcontroller.text);
                            _submit();
                          },),
                        //here old

                        //  if (_key.currentState!.validate()) {};


                        // color: Colors.white,


                      ],

                    ),
                  ),
                ),
              ),
            ),
          )
        ],

      ),


    Request request = Request(username);
    Snackbar? snackbar;
    String msg = "";

    await FirebaseFirestore.instance
        .collection('requests')
        .add(request.toJson())
        .then((value) => {msg = 'Request added successfully'})
        .catchError((error) => msg = "Failed to add request: $error");
    }




);
  }

  }
