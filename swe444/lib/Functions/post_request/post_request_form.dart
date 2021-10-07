import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
import 'package:swe444/Functions/post_request/request_view_model.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

class PostRequestForm extends StatefulWidget {
  PostRequestForm({
    Key? key,
  }) : super(key: key);

  @override
  _AddRequestFormState createState() => _AddRequestFormState();
}

class _AddRequestFormState extends State<PostRequestForm> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String? type, mosque_name, mosque_location;
  String? postedBy;
  int? amount;
  TextEditingController _amount =  TextEditingController();
  TextEditingController title= TextEditingController();
  DateTime time = DateTime.now();
  final List<String> items = <String>['مبلغ'];
  TextEditingController description= TextEditingController();


  Widget _buildType(bool orientation) {
    double h1 = 0, h2 = 0, b1 = 0;
    if (orientation == true) {
      h1 = 10;
      b1 = 5;
      h2 = 18;
    } else {
      h1 = 60;
      h2 = 70;
      b1 = 5;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 55.h : 110.h,
      // margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 35.h : 70.h,
                    padding: EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 55.h : 110.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: h2, right: h2, top: b1),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration.collapsed(
                            hintText: "",
                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return items.map<Widget>((String item) {
                              return Container(
                                alignment: Alignment.centerRight,
                                width: 120,
                                child: Text(
                                  item,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          value: type,
                          items: items.map<DropdownMenuItem<String>>(
                              (dropdownMenuItem) {
                            return DropdownMenuItem(
                              value: dropdownMenuItem,
                              child: SizedBox(
                                width: 150.w,
                                child: Text(
                                  dropdownMenuItem,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => this.type = value),
                          validator: (value) =>
                              value == null ? 'مطلوب' : null,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          hint: Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: SizedBox(
                              width: 125.w,
                              child: Text(
                                "اختر نوعًا",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          ),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: orientation == true ? 40.w : 30.w,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, right: 5),
              child: const Text("*",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xffa01527),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    fontSize: 17,
                  )),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              ),
              Text(
                "نوع الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle(bool orientation) {
    double h1 = 0, l1 = 0, l2 = 0;
    if (orientation == true) {
      h1 = 10;
      l1 = 9.w;
      l2 = 0;
    } else {
      h1 = 60;
      l1 = 15.w;
      l2 = 12.w;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 60.h : 120.h,
      child: Row(
        children: [
          Column(children: [
            Stack(children: <Widget>[
              Container(
                width: orientation == true ? 190.w : 180.w,
                height: orientation == true ? 33.h : 70.h,
                padding: EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xffffffff),
                    border:
                        Border.all(width: 0.5, color: const Color(0xffdfdfdf)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: orientation == true ? 180.w : 140.w,
                height: orientation == true ? 58.h : 120.h,
                margin: EdgeInsets.only(left: l2),
                child: Padding(
                  padding: EdgeInsets.only(left: l1),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.trim().isEmpty)
                        return "مطلوب";
                      if (value.length > 30)
                        return "لا يمكن ان يزيد عن 30 حرف ";
                    },
                    controller: title,
                    decoration: InputDecoration(
                        hintText: "العنوان",
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 16),
                        hintStyle: const TextStyle(
                            fontSize: 14, fontFamily: "Tajawal")),
                    onSaved: (_val) {
                      if (_val != null)
                          title.text = _val;
                    }, // onchanged
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  ),
                ),
              ),
            ]),
          ]),
          SizedBox(
            width: orientation == true ? 40.w : 30.w,
            child: Padding(
              padding: EdgeInsets.only(bottom: 35.0, right: 15.w),
              child: const Text("*",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xffa01527),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    fontSize: 17,
                  )),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              ),
              Text(
                "عنوان الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetails(bool orientation) {
    double h1 = 0, h2 = 0, _value = 0, l2 = 0, l3 = 0, t1 = 0;

    if (orientation == true) {
      h1 = 15;
      h2 = 25;
      l2 = 13.w;
      t1 = 10.h;
      l3 = 25.w;
    } else {
      l2 = 27.w;
      h1 = 60;
      h2 = 0;
      t1 = 15.h;
      l3 = 30.w;
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: orientation == true ? 293.w : 240.w,
              height: orientation == true ? 20.h : 110.h,
              margin: EdgeInsets.only(bottom: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  "تفاصيل الطلب",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: const Color(0xff334856),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    fontSize: 15,
                  ),
                ),
              ]),
            ),
          ],
        ),
        Row(
          children: [
            Stack(children: <Widget>[
              Container(
                width: orientation == true ? 150.w : 130.w,
                height: orientation == true ? 38.h : 70.h,
                padding: EdgeInsets.only(left: h1, top: 0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xffffffff),
                    border:
                        Border.all(width: 0.5, color: const Color(0xffdfdfdf)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: orientation == true ? 174.w : 130.w,
                height: orientation == true ? 62.h : 120.h,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: h2, left: l2, bottom: 0, top: 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.trim().isEmpty)
                        return "مطلوب";
                      else {
                        _value = double.parse(value);
                        if (_value > 50000 )
                          return "الآقصى= 50000";
                        if (_value < 10)
                          return "الآدنى= 10";
                      }
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        hintText: "000",
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(38.w, 0, 15.w, 12.h),
                        hintStyle: const TextStyle(
                            fontSize: 17, fontFamily: "Tajawal")),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    onSaved: (_val) {
                      if (_val != null) {
                        _amount.text = _val;
                      }}, // onsaved
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 160, top: 7),
                child: const Text("*",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xffa01527),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Tajawal',
                      fontSize: 17,
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(l3, t1, 0, 0),
                child: Text(
                  'ريال',
                  style: TextStyle(
                    fontFamily: 'Academy Engraved LET',
                    fontSize: 12,
                    color: const Color(0xffd2d2d2),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h, left: 0),
                  child: Text(
                    "المبلغ",
                    style: TextStyle(fontFamily: "Tajawal"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription(bool orientation) {
    double h1 = 0, l1;
    if (orientation == true) {
      h1 = 10;
      l1 = 0;
    } else {
      l1 = 20;
      h1 = 60;
    }

    return Container(
      width: orientation == true ? 300.w : 300.w,
      height: orientation == true ? 140.h : 285.h,
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      "وصف إضافي",
                      style: TextStyle(
                        color: const Color(0xff334856),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(width: orientation == true ? 15.w : 29.w),
                  ],
                )
              ]),
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20, left: l1),
                        width: orientation == true ? 300.w : 250.w,
                        height: orientation == true ? 90.h : 200.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffdfdfdf)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 16, 0, 16),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(150)
                              ],
                              controller: description,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              onSaved: (_val) {
                                if (_val != null)
                                description.text = _val;
                              }, // onsaved
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

// https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095
  showAlertDialog(String? id) {
    // set up the buttons
    Widget cancelButton =  Padding(
      padding: EdgeInsets.only(right: 40.w, top: 20.h, bottom: 30.h),
        child:ElevatedButton(
      child: const Text(
        "إلغاء",
        style: TextStyle(color: const Color(0xdeedd03c), fontFamily: "Tajawal"),
      ),
      onPressed: () {
        Navigator.of(context).pop(context);
      },
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(
              const Color(0xdeffffff)),
          elevation:
          MaterialStateProperty.all<double>(0)),
        ), );
    Widget confirmButton =
    Padding(
        padding: EdgeInsets.only(right: 40.w, top: 20.h, bottom: 30.h),
   child: ElevatedButton(

      child: Text(
        "تأكيد",
        style: TextStyle(fontFamily: "Tajawal"),
      ),

      style: ButtonStyle(


          backgroundColor:
          MaterialStateProperty.all<Color>(
              const Color(0xdeedd03c))),

      onPressed: () {
        Navigator.of(context).pop(context);
        add(id);
      },


   ), );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
      title: Text(
        "إضافة",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: const Color(0xdeedd03c),
          fontFamily: 'Tajawal',
        ),

      ),


      content: Text(
        "هل أنت متأكد من رغبتك في\n إضافة الطلب؟",
        textAlign: TextAlign.center,
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
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: portrait == true ? 300.w : 400.w,
              child: _buildType(portrait),
            ),
            // email container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: portrait == true ? 300.w : 400.w,
              child: _buildTitle(portrait),
            ), // password container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: portrait == true ? 300.w : 400.w,
              child: _buildDetails(portrait),
            ), // conform container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: portrait == true ? 300.w : 400.w,
              child: _buildDescription(portrait),
            ), // mosque name
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
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showAlertDialog(user?.uid.toString());
                }
              },
              child: Text(
                "إضافة",
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
          ],
        ),
      ),
    );
  }

  void add(String? id) async {
    RequestViewModel requestVM= RequestViewModel();
    // save to db
    // postedBy = id;
    // FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);

    requestVM.postedBy = id;

    var document =
    await requestVM.userDocument;

    if (document.exists) {
      Map<String, dynamic>? data = document.data();
      requestVM.setMName = data?['mosque_name'];
      requestVM.setMLocation = data?['location'];

      requestVM.setDescription= description.text;
      requestVM.setTitle= title.text;
      requestVM.setType= type;
      requestVM.setUploadTime= time;
      amount = int.parse(_amount.text);
      requestVM.setAmount = amount;

      await requestVM.add();

      Snackbar? snackbar;
      String msg = requestVM.message;

      snackbar = Snackbar(context, msg);
      snackbar.showToast();

      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => mmHome()), (route) => false);

      _formKey.currentState?.reset();
    } else {
      Snackbar snackbar2 = Snackbar(context, "لا يمكن اضافة الطلب");
      snackbar2.showToast();
    }
  }
}
