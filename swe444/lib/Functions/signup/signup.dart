import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
import 'package:swe444/Models/SignupMViewModel.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
import '../signup_login_screen.dart';

class SignUpPage extends StatefulWidget {
  final Function(User) onSignIn;

  const SignUpPage({required this.onSignIn});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final TextEditingController _controllerPass2 = TextEditingController();
  final TextEditingController mosqueName = TextEditingController();
  final TextEditingController phoneNum = TextEditingController();
  final TextEditingController mosqueLocation = TextEditingController();
  final TextEditingController mosqueCode = TextEditingController();

  String errorMessage = "";

  final _formKey = GlobalKey<FormState>();
//1
  static const kYellow = const Color(0xdeedd03c);
  String error = "";
  bool isLogin = true;

  final _auth = FirebaseAuth.instance;
  Snackbar? snackbar;
  Snackbar? snackbar2, snackbar3;
  bool valid = true;
//1
  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("الرجاء قم بإدخال بريد إلكتروني");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("البريد الإلكتروني غير صحيح");
        }
        return null;
      },
      onSaved: (value) {
        _controllerEmail.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: _controllerEmail,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
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
        //border: OutlineInputBorder(),
        // hoverColor: const Color(0xff334856),
      ),
      autocorrect: false,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("الرجاء تعيين كلمة مرور");
        }
        if (!regex.hasMatch(value)) {
          return ("يجب أن تحتوي على 6 رموز او أكثر");
        }
      },
      onSaved: (value) {
        _controllerPass.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: _controllerPass,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل كلمة السر',
        labelText: 'كلمة السر',
        hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        labelStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      autocorrect: false,
      obscureText: true,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return ("رجاءً قم بتأكيد كلمة مرور");
        }
        if (_controllerPass2.text != _controllerPass.text) {
          return "كلمة المرور مختلفة";
        }
        return null;
      },
      onSaved: (value) {
        _controllerPass2.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: _controllerPass2,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل كلمة السر مره اخرى',
        labelText: 'تاكيد كلمة السر',
        hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        labelStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      autocorrect: false,
      obscureText: true,
    );
  }

  Widget _buildMosqueNameField() {
    return TextFormField(
      onSaved: (value) {
        mosqueName.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return ("الرجاء قم بإدخال اسم المسجد");
        }
        if (!regex.hasMatch(value)) {
          return ("يجب ان يحتوي على 5 حروف على الأقل");
        }
        return null;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: mosqueName,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.account_balance,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل اسم المسجد',
        labelText: 'اسم المسجد',
        hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),

        labelStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      autocorrect: false,
      obscureText: false,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      onSaved: (value) {
        phoneNum.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^((?:[0?5?]+)(?:\s?\d{8}))$');
        if (value!.isEmpty) {
          return ("الرجاء إدخال رقم جوال المسجد ");
        }
        if (!regex.hasMatch(value)) {
          return ("رقم الجوال المدخل غير صالح");
        }
        if (value.length < 10) {
          return ("رقم الجوال المدخل غير صالح");
        }
        return null;
      },
      maxLength: 10,
      keyboardType: TextInputType.phone,
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: phoneNum,
      decoration: InputDecoration(
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        hintText: 'أدخل رقم الجوال',
        labelText: 'رقم الجوال',
        hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        labelStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      autocorrect: false,
      obscureText: false,
    );
  }

  Widget _buildCodeField() {
    return TextFormField(
      onSaved: (value) {
        mosqueCode.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("الرجاء قم بإدخال رمز المسجد");
        }
        return null;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      maxLength: 8,
      keyboardType: TextInputType.number,
      // style:
      //     TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: mosqueCode,
      decoration: InputDecoration(
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border

          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xdeedd03c),
          ),
        ),
        prefixIcon: Icon(
          Icons.shield,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل كود المسجد',
        labelText: 'كود المسجد',
        hintStyle: TextStyle(
            fontSize: 14,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        labelStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      autocorrect: false,
      obscureText: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 0,
                    left: 290,
                    top: 45,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupLoginScreen()));
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      textDirection: TextDirection.rtl,
                      size: 30,
                      color: Color(0xff334856),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 160,
                              width: 160,
                              child: Image.asset('images/logo.png')), // email
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 55),
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
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildEmailField(),
                        ),
                      ), // email container
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildPasswordField(),
                        ),
                      ), // password container
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildConfirmPasswordField(),
                        ),
                      ), // conform container
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildMosqueNameField(),
                        ),
                      ), // mosque name
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildPhoneField(),
                        ),
                      ), // phone
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      // Container(
                      //   width: 330,
                      //   child: Directionality(
                      //     textDirection: TextDirection.rtl,
                      //     child: _buildLocationField(),
                      //   ),
                      // ), // location
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.02,
                      // ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildCodeField(),
                        ),
                      ), // code
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signUp(_controllerEmail.text, _controllerPass.text);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(180.w, 50.h),
                            primary: const Color(0xdeedd03c),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            "التسجيل",
                            style: TextStyle(
                                color: Color(0xff334856),
                                fontSize: 20,
                                fontFamily: 'Tajawal'),
                          )),
                      Text(error),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    SignupMViewModel volunteer = SignupMViewModel();

    if (_formKey.currentState!.validate()) {
      volunteer.emailSet = _controllerEmail.text;
      // volunteer.uID = id;
      volunteer.mosqueName = mosqueName.text;
      volunteer.mosquePhone = int.parse(phoneNum.text);
      volunteer.mosqueCode = mosqueCode.text;
      volunteer.userRole = 'mosqueManager';
      await volunteer.signUp(email, password);

      Snackbar? snackbar;
      String msg = volunteer.message;
      snackbar = Snackbar(context, msg);
      snackbar.showToast();

      if (volunteer.valid == true) {
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => mmHome()),
            (route) => false);
      }
    }
  }
}
