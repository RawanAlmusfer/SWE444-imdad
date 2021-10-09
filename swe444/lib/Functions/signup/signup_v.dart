import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/v_home_view.dart';
import '../../Models/VUserModel.dart';
import '../../Widgets/show_snackbar.dart';
import '../signup_login_screen.dart';

class VSignUpPage extends StatefulWidget {
  final Function(User) onSignIn;

  const VSignUpPage({required this.onSignIn});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<VSignUpPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final TextEditingController _controllerPass2 = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNum = TextEditingController();
  final TextEditingController mosqueLocation = TextEditingController();
  final TextEditingController mosqueCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static const kYellow = const Color(0xdeedd03c);
  String error = "";
  bool isLogin = true;
  String errorMessage = "";

  final _auth = FirebaseAuth.instance;
  Snackbar? snackbar;
  Snackbar? snackbar2;
  Snackbar? snackbar3;
  bool valid = true;

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

  Widget _buildConformPasswordField() {
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

  Widget _buildfirstNameField() {
    return TextFormField(
      onSaved: (value) {
        firstName.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ("الرجاء قم بإدخال اسمك الاول");
        }
        if (!regex.hasMatch(value)) {
          return ("يجب ان يحتوي على حرفين على الأقل");
        }
        return null;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: firstName,
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
          Icons.perm_identity,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل اسمك الاول',
        labelText: 'الاسم الاول',
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

  Widget _buildlastNameField() {
    return TextFormField(
      onSaved: (value) {
        lastName.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ("الرجاء قم بإدخال اسم عائلتك");
        }
        if (!regex.hasMatch(value)) {
          return ("يجب ان يحتوي على حرفين على الأقل");
        }
        return null;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      controller: lastName,
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
          Icons.perm_identity,
          color: const Color(0xff334856),
        ),
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: 'أدخل اسم عائلتك',
        labelText: 'اسم العائلة',
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
          return ("الرجاء إدخال رقم الجوال ");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Phone number");
        }
        if (value.length < 10) {
          return ("Enter Valid Phone number");
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
        //border: OutlineInputBorder(),
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
                          child: _buildConformPasswordField(),
                        ),
                      ), // conform container
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildfirstNameField(),
                        ),
                      ), // mosque name
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: 330,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: _buildlastNameField(),
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
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()});
        login();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "email-already-in-use":
            setState(() {
              errorMessage = 'البريد الإلكتروني مستخدم مسبقًا';
            });
            break;
          case "invalid-email":
            setState(() {
              errorMessage = 'البديد الإلكتروني غير صالح';
            });
            break;
          case "too-many-requests":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "operation-not-allowed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "network-request-failed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "credential-already-in-use":
            setState(() {
              errorMessage =
                  'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';
            });
            break;
          default:
            setState(() {
              errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
            });
            break;
        }
        snackbar2 = Snackbar(context, errorMessage);
        snackbar2!.showToast();
      }
      ;
      if (_controllerEmail.text.isEmpty && _controllerPass.text.isEmpty) {
        errorMessage = "الرجاء إدخال البريد الالكتروني وكلمة السر ";
      } else if (_controllerEmail.text.isEmpty) {
        errorMessage = " الرجاء إدخال البريد الالكتروني ";
      } else if (_controllerPass.text.isEmpty) {
        errorMessage = "الرجاء إدخال كلمة السر ";

        switch ("invalid-email") {
          case "invalid-email":
            errorMessage = 'البريد الالكتروني غير صحيح';
            break;
          case "too-many-requests":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "operation-not-allowed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "network-request-failed":
            setState(() {
              errorMessage =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';
            });
            break;
          case "credential-already-in-use":
            setState(() {
              errorMessage =
                  'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';
            });
            break;
          default:
            setState(() {
              errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
            });
            break;
        }
        snackbar3 = Snackbar(context, errorMessage);
        snackbar3!.showToast();
      } //end 2ed switch
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    VUserModel userModel = VUserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.first_name = firstName.text;
    userModel.last_name = lastName.text;
    userModel.volunteer_phone = int.parse(phoneNum.text);
    userModel.role = 'volunteer';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) => snackbar = Snackbar(context, "تم التسجيل بنجاح "))
        .catchError((e) {
      valid = false;
      snackbar = Snackbar(context, "حدث خطأ ");
    });

    snackbar?.showToast();

    if (valid == true) {
      login();
      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => vHome()), (route) => false);
    }
  }
}
