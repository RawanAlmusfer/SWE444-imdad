import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
import 'package:swe444/Models/MUserModel.dart';
import 'package:swe444/Widgets/show_snackbar.dart';



class EditProfileForm extends StatefulWidget {
  final DocumentSnapshot document;
  EditProfileForm({
    Key? key,
    required this.document
  }) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String? email;
  int? phone;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();


  @override
  void initState() {
    super.initState();
    _name.text = widget.document['mosque_name'].toString();
    _email.text = user!.email.toString();
    _phone.text = '0' + widget.document['phone_number'].toString();
    _code.text = widget.document['mosque_code'].toString();
  }

  Widget _buildMosqueNameField() {
    return TextFormField(
      enabled: false,
      readOnly: true,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        _name.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{5,}$');
        if (value!.isEmpty || value
            .trim()
            .isEmpty) {
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
      style: TextStyle(fontSize: 18, color: const Color(0xff6a6a6a)),
      textAlign: TextAlign.right,
      controller: _name,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 5, top: 15),
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

  Widget _buildEmailField() {
    return TextFormField(
      enabled: false,
      readOnly: true,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || value
            .trim()
            .isEmpty) {
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
        _email.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff6a6a6a)),
      textAlign: TextAlign.right,
      controller: _email,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 5, top: 15, left: 5),
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

  Widget _buildPhoneField() {
    return TextFormField(
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) {
        _phone.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^((?:[0?5?]+)(?:\s?\d{8}))$');
        if (value!.isEmpty || value
            .trim()
            .isEmpty) {
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
      controller: _phone,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 5, top: 15),
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
      enabled: false,
      readOnly: true,
      onSaved: (value) {
        _code.text = value!;
      },
      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      textAlign: TextAlign.right,
      style: TextStyle(fontSize: 18, color: const Color(0xff6a6a6a)),
      controller: _code,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 5, top: 15),
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


  String getText(DateTime day) {
     return '${day.month}/${day.day}/${day.year}';
  }


// https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095
  showAlertDialog(String? id) {
    // set up the buttons
    Widget cancelButton = Padding(
      padding: EdgeInsets.only(right: 40.w, top: 20.h, bottom: 30.h),
      child: ElevatedButton(
        child: const Text(
          "إلغاء",
          style:
          TextStyle(color: const Color(0xdeedd03c), fontFamily: "Tajawal"),
        ),
        onPressed: () {
          Navigator.of(context).pop(context);
        },
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xdeffffff)),
            elevation: MaterialStateProperty.all<double>(0)),
      ),
    );
    Widget confirmButton = Padding(
      padding: EdgeInsets.only(right: 40.w, top: 20.h, bottom: 30.h),
      child: ElevatedButton(
        child: Text(
          "تأكيد",
          style: TextStyle(fontFamily: "Tajawal"),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xdeedd03c))),
        onPressed: () {
          Navigator.of(context).pop(context);
          update(id);
        },
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
      title: Text(
        "تعديل",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: const Color(0xdeedd03c),
          fontFamily: 'Tajawal',
        ),
      ),
      content: Text(
        "هل أنت متأكد من رغبتك في\n تعديل الملف الشخصي؟",
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              width: portrait == true ? 265.w : 300.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: _buildMosqueNameField(),
              ),
            ), // password container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            Container(
              width: portrait == true ? 265.w : 310.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: _buildCodeField(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            Container(
              width: portrait == true ? 265.w : 310.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: _buildEmailField(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            Container(
              width: portrait == true ? 265.w : 310.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: _buildPhoneField(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showAlertDialog(user?.uid.toString());
                }
              },
              child: Text(
                "تعديل",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120.w, 35.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                primary: const Color(0xdeedd03c),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  void update(String? id) async {

    if (widget.document.exists) {
      SignupMViewModel userVM= new SignupMViewModel();
      userVM.uID = widget.document['uid'].toString();
      userVM.mosque_location = widget.document['location'].toString();
      userVM.mosque_code = widget.document['mosque_code'].toString();
      userVM.role= widget.document['role'].toString();
      userVM.mosque_phone= int.parse(_phone.text);
      userVM.email= widget.document['email'].toString();
      userVM.mosque_name= widget.document['mosque_name'].toString();


      await userVM.update(widget.document.id, user);

      Snackbar? snackbar;
      String msg = userVM.message;
      String msgType = userVM.msgType;

      snackbar = Snackbar(context, msg, msgType);
      snackbar.showToast();


      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => mmHome()), (route) => false);

    } else {
      Snackbar snackbar2 = Snackbar(context, "لا يمكن تحديث الملف الشخصي", "fail");
      snackbar2.showToast();
    }
  }
}
