import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
import 'package:swe444/Models/MUserModel.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
import 'package:swe444/password/flutter_pw_validator.dart';
import '../signup_login_screen.dart';

class SignUpPage extends StatefulWidget {
  final Function(User) onSignIn;

  const SignUpPage({Key? key, required this.onSignIn}) : super(key: key);

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
  String? mCodeMessage = null;
  final _formKey = GlobalKey<FormState>();

  static const kYellow = const Color(0xdeedd03c);
  String error = "";
  bool isLogin = true;
  bool isFoucesedPassword = false;
  final _auth = FirebaseAuth.instance;
  Snackbar? snackbar;
  Snackbar? snackbar2, snackbar3;
  bool valid = true;

  Widget _buildEmailField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return ("الرجاء قم بإدخال بريد إلكتروني");
        }
        // reg expression for email validation
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("البريد الإلكتروني غير صحيح");
        }

        return null;
      },
      onSaved: (value) {
        _controllerEmail.text = value!;
      },
      showCursor: true,
      maxLines: 2,
      minLines: 1,
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
        labelText: 'البريد الالكتروني*',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty || value.trim().isEmpty) {
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
      style: TextStyle(fontSize: 15, color: const Color(0xff334856)),
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
        hintText: 'أدخل كلمة المرور',
        labelText: 'كلمة المرور*',
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
      onTap: () {
        setState(() {
          isFoucesedPassword = true;
        });
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return ("رجاءً قم بتأكيد كلمة مرور");
        }
        if (_controllerPass2.text != _controllerPass.text) {
          return "كلمة المرور مختلفة*";
        }
        return null;
      },
      onSaved: (value) {
        _controllerPass2.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 15, color: const Color(0xff334856)),
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
        hintText: 'أدخل كلمة المرور مره اخرى',
        labelText: 'تاكيد كلمة المرور*',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        mosqueName.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{5,}$');
        if (value!.isEmpty || value.trim().isEmpty) {
          return ("الرجاء قم بإدخال اسم المسجد");
        }
        if (!regex.hasMatch(value)) {
          return ("يجب ان يحتوي على 5 حروف على الأقل");
        }
        if (!RegExp(r"^[\p{L} ,.'-]*$",
                caseSensitive: false, unicode: true, dotAll: true)
            .hasMatch(value)) {
          return ("يجب ان يحتوي اسم المسجد على أحرف فقط");
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
        labelText: 'اسم المسجد*',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        phoneNum.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^((?:[0?5?]+)(?:\s?\d{8}))$');
        if (value!.isEmpty || value.trim().isEmpty) {
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
        labelText: 'رقم الجوال*',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        mosqueCode.text = value!;
      },
      validator: (value) {
        var pattern = r'\d{2}-\d{5}';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value!))
          return 'الرجاء ادخال رقم كود المسجد';
        else
          return null;
      },
      //keyboardType: TextInputType.numberWithOptions(decimal: true),

      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      maxLength: 8,
      //keyboardType: TextInputType.number,
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
        labelText: 'كود المسجد*',
        errorText: mCodeMessage,

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 55),
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
                        ),
                        // Visibility(
                        //   visible: isFoucesedPassword,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: FlutterPwValidator(
                        //         controller: _controllerPass,
                        //         minLength: 6,

                        //         uppercaseCharCount: 2,
                        //         numericCharCount: 3,
                        //        specialCharCount: 1,
                        //         width: 360,
                        //         height: 150,
                        //         onSuccess: (value) {
                        //           //_controllerPass.text = value;
                        //         }),
                        //   ),
                        // ), // password container
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
                              signUp(
                                  _controllerEmail.text, _controllerPass.text);
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
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> authen() async {
    {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _controllerEmail.text, password: _controllerPass.text);
        print(userCredential.user);
        widget.onSignIn(userCredential.user!);
        //
      } on FirebaseAuthException catch (e) {
        //Snackbar(context, e.toString()).showToast();
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore
          .collection('mosques_code')
          .where('code', isEqualTo: mosqueCode.text)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          try {
            _auth
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((value) => {postDetailsToFirestore()});
            authen();
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

              case "invalid-email":
                errorMessage = 'البريد الالكتروني غير صحيح';
                break;

              default:
                setState(() {
                  errorMessage = 'حدث خطأ ما ، أعد المحاولة من فضلك';
                });
                break;
            }
            snackbar2 = Snackbar(context, errorMessage, "fail");
            snackbar2!.showToast();
          }
          ;
          if (_controllerEmail.text.isEmpty && _controllerPass.text.isEmpty) {
            errorMessage = "الرجاء إدخال البريد الالكتروني وكلمة المرور ";
          } else if (_controllerEmail.text.isEmpty) {
            errorMessage = " الرجاء إدخال البريد الالكتروني ";
          } else if (_controllerPass.text.isEmpty) {
            errorMessage = "الرجاء إدخال كلمة المرور ";

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
            snackbar3 = Snackbar(context, errorMessage, "fail");
            snackbar3!.showToast();
          } //end 2ed switch
        } else {
          setState(() {
            mCodeMessage = 'كود المسجد المدخل غير صالح';
          });
        }
        ;
      }).catchError((error) {
        // Snackbar sb = Snackbar(context, "كود المسجد المدخل غير صالح");
        // sb.showToast();
        setState(() {
          mCodeMessage = 'bla bla bal';
        });
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    MViewModel userModel = MViewModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.mosque_name = mosqueName.text;
    userModel.mosque_phone = int.parse(phoneNum.text);
    // userModel.mosque_location = mosqueLocation.text;
    userModel.mosque_code = mosqueCode.text;
    userModel.role = 'mosqueManager';

    await firebaseFirestore
        .collection('mosques_code')
        .where('code', isEqualTo: userModel.mosque_code)
        .get()
        .then((mosques) {
      for (var mosque in mosques.docs) {
        Map<String, dynamic>? data = mosque.data();
        userModel.mosque_location = data['location'];
        firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap())
            .then((value) {
          snackbar = new Snackbar(context, "تم التسجيل بنجاح ", "success");
        }).catchError(
          (e) {
            valid = false;
            snackbar = new Snackbar(context, "حدث خطأ ", "fail");
          },
        );
      }
    }).catchError(
      (e) {
        valid = false;
        snackbar = new Snackbar(context, "حدث خطأ ", "fail");
      },
    );

    snackbar?.showToast();

    if (valid == true) {
      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => mmHome()), (route) => false);
    }
  }
}
