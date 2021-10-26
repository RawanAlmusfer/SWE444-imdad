import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
import 'login_page.dart';
import 'package:swe444/Functions/decisions_tree.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  static const kYellow = const Color(0xdeedd03c);
  TextEditingController _controllerEmail = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage, errorMessage2;

  Snackbar? snackbar, snackbar2, snackbar3;

  Future<void> resetPass() async {
    if (_formKey.currentState!.validate()) {
      if (_controllerEmail.text.isNotEmpty) {
        try {
          await auth.sendPasswordResetEmail(email: _controllerEmail.text);
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "invalid-email":
              setState(() {
                errorMessage = 'البريد الالكتروني غير صحيح';
              });
              break;

            case "missing-android-pkg-name":
              setState(() {
                errorMessage =
                    'يجب تقديم اسم حزمة Android إذا كان تطبيق Android مطلوبًا ليتم تثبيته';
              });
              break;

            case "missing-continue-uri":
              setState(() {
                errorMessage = 'يجب توفير عنوان URL للمتابعة في الطلب';
              });
              break;

            case "missing-ios-bundle-id":
              setState(() {
                errorMessage =
                    'يجب توفير معرف حزمة iOS إذا تم توفير معرف متجر التطبيقات';
              });
              break;

            case "invalid-continue-uri":
              setState(() {
                errorMessage = 'عنوان URL للمتابعة المقدم في الطلب غير صالح';
              });
              break;

            case "unauthorized-continue-uri":
              setState(() {
                errorMessage =
                    'نطاق عنوان URL للمتابعة غير مدرج في القائمة البيضاء. أضف النطاق إلى القائمة البيضاء في وحدة تحكم Firebase';
              });
              break;

            case "user-not-found":
              setState(() {
                errorMessage =
                    'لايوجد هناك مستخدم مطابق لعنوان البريد الإلكتروني المُدخل';
              });
              break;
            default:
              setState(() {
                errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
              });
              break;
          }

          if (errorMessage != null) {
            snackbar = Snackbar(context, errorMessage!, "fail");
            snackbar!.showToast();
            errorMessage = null;
          }
        }
      } //end if

      if (_controllerEmail.text.isEmpty) {
        errorMessage2 = " الرجاء إدخال البريد الالكتروني ";
      }

      if (errorMessage2 != null) {
        snackbar2 = Snackbar(context, errorMessage2!, "fail");
        snackbar2!.showToast();
      }

      if (errorMessage == null) {
        snackbar3 = Snackbar(context,
            "تم إسال رابط تفعيل  لكلمة المرور الجديدة على البريد الالكتروني الذي تم تزويدنا فيه", "success");
        snackbar3!.showToast();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DecisionsTree()));
      }
    }
  } //end login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: new EdgeInsets.all(15.0),
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
                            builder: (context) => LoginPage(
                                  onSignIn: (User) {
                                    DecisionsTree();
                                  },
                                )));
                  },
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    textDirection: TextDirection.rtl,
                    size: 30,
                    color: Color(0xff334856),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, top: 70),
                                child: Container(
                                    height: 160,
                                    width: 160,
                                    child: Image.asset('images/logo.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0, top: 115),
                                child: const Text(
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
                          new Directionality(
                            textDirection: TextDirection.rtl,
                            child: new TextFormField(
                              showCursor: true,
                              cursorColor: const Color(0xdeedd03c),
                              textAlign: TextAlign.right,
                              controller: _controllerEmail,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("الرجاء إدخال البريد الإلكتروني ");
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(
                                    color: kYellow,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: const Color(0xff334856),
                                ),
                                prefixStyle: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xff334856)),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              autocorrect: false,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
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
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              resetPass();
                            },
                            child: const Text(
                              'إعادة ضبط كلمة المرور',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Tajawal',
                                  color: Color(0xff334856),
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(300, 64),
                              primary: const Color(0xdeedd03c),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
