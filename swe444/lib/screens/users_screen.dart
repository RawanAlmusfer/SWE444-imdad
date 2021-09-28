import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import 'home_screen.dart';

class UsersScreen extends StatefulWidget {

  UsersScreen.ensureInitialized();
  const UsersScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<UsersScreen> {
  //FirebaseFirestore Firestore = FirebaseFirestore.instance;
  //FirebaseApp secondaryApp = Firebase.app('SecondaryApp');


  final GlobalKey<FormState> _formKey = GlobalKey();
  final _key = GlobalKey<FormState>();



  final TextEditingController _passwordController = TextEditingController();

  //final TextEditingController _usernamecontroller =  TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

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
       //Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }
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
    child: Form(
    key: _formKey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [

               /// Image.asset('assets/logo.png',width:50,height:50),


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
                    controller: _emailcontroller,
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
                    controller: _passwordController,
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
                  //  onSaved: (value) {
                  //    _authData['email'] = value!;
                  //  },
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
                new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new TextFormField(
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
                    },
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

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {_submit();},
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
      ),
    );
  }
}