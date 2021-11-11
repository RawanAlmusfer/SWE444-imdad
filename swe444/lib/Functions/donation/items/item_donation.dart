import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:swe444/Functions/request/request_view_model.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

class ItemsDScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const ItemsDScreen({Key? key, required this.document}) : super(key: key);

  @override
  _ItemsDScreenState createState() => _ItemsDScreenState();
}

class _ItemsDScreenState extends State<ItemsDScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  int? donated;
  int? amount;

  //int? vDonatedAmount=int.parse(_controller.text);

  @override
  void initState() {
    super.initState();
    donated = int.parse(widget.document['donated'].toString());
    amount = int.parse(widget.document['amount_requested'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Row(
            children: [
              Text(
                "عملية التبرع بالموارد",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff334856),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      textDirection: TextDirection.rtl,
                      size: 30,
                      color: Color(0xff334856),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //   Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
        //automaticallyImplyLeading: false,
        backgroundColor: const Color(0xdeedd03c),
        bottomOpacity: 30,
        // elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 0,
          left: 50,
          right: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: 280,
                  width: 280,
                  child: Image.asset('images/items.png')),
              Form(
                key: _formKey,
                child: Container(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      controller: _controller,
                      decoration: InputDecoration(
                        hoverColor: const Color(0xff334856),
                        alignLabelWithHint: true,

                        //  textAlign: TextAlign.end,
                        hintText: 'الكمية ',
                        //    hintTextDirection: TextAlign.left,
                        labelText: 'أدخل عدد الموارد المراد التبرع بها',
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        labelStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        focusedBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xdeedd03c),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 5,
                              color: Color(0xdeedd03c),
                            )),
                      ),
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      ],
                      onSaved: (value) {
                        _controller.text = value!;
                      },
                      validator: (value) {
                        // String text = _controller.text;
                        value = _controller.text;

                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty)
                          return "الرجاء إدخال قيمة التبرع المرغوبة";
                        else {
                          if (value != null) {
                            int donation = int.parse(value);
                            if (amount != null && donated != null) {
                              int check = amount! - donated!;
                              if (donation == 0) return "أدنى قيمة للتبرع = 1";

                              if (check == 0)
                                return "الحالة مكتملة ، شكراً لتعاونك";

                              if (donation > check)
                                return " قيمة التبرع أكبر من الكمية المطلوبة ، الكمية المتبقية $check";
                            }
                          }
                        }

                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    RequestViewModel requestVM = new RequestViewModel();
                    if (user != null)
                      await requestVM.donateItems(
                          widget.document, _controller.text, user!);
                    if (requestVM.msgType == "success") {
                      showAlertDialog(context);
                    } else if (requestVM.msgType == "fail") {
                      var snackbar =
                          Snackbar(context, requestVM.message, "fail");
                      snackbar.showToast();
                    }
                  } else {
                    String errorMessage =
                        'الرجاء التأكد من القيمة العددية المدخلة';
                    var snackbar2 = Snackbar(context, errorMessage, "fail");
                    snackbar2.showToast();
                  }
                },
                child: Text(
                  'سجل تبرعك الآن',
                  style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(85.w, 40.h),
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
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "موافق",
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xdeedd03c))),
      onPressed: () {
        Navigator.of(context).pop(context);
        Navigator.of(context).pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
      title: Text(
        "تأكيد التبرع ",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Tajawal",
          color: const Color(0xdeedd03c),
        ),
      ),
      content: Text(
        "تمت تسجيل التبرع بنجاح",
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      actions: [
        okButton,
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
}
