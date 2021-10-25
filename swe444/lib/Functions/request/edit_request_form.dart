import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_home_view.dart';
import 'package:swe444/Functions/request/request_view_model.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

class EditRequestForm extends StatefulWidget {
  final DocumentSnapshot document;
  EditRequestForm({
    Key? key, required this.document,
  }) : super(key: key);

  @override
  _EditRequestFormState createState() => _EditRequestFormState();
}

class _EditRequestFormState extends State<EditRequestForm> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String? type, mosque_name, mosque_location;
  String? postedBy;
  int? amount;
  int? items_amount;
  int charLength= 0;
  TextEditingController _amount = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController itemsAmount = TextEditingController();
  DateTime time = DateTime.now();
  final List<String> items = <String>['مبلغ', 'موارد'];
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    title.text= widget.document['title'].toString();
    description.text= widget.document['description'].toString();
    type = widget.document['type'].toString();
    if (type == "مبلغ")
      _amount.text= widget.document['amount'].toString();
    if (type == "موارد")
      itemsAmount.text= widget.document['amount_requested'].toString();
  }

  // Widget _buildType() {
  //   return DropdownButtonHideUnderline(
  //       child: DropdownButtonFormField<String>(
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             // width: 0.0 produces a thin "hairline" border
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide(
  //               color: const Color(0xdeedd03c),
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.only(right: 20, top: 15, left: 23 ),
  //           prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
  //           hoverColor: const Color(0xff334856),
  //           hintText: 'إختر نوعًا',
  //           labelText: ' نوع الطلب *',
  //           hintStyle: TextStyle(
  //               fontSize: 13,
  //               color: const Color(0xff334856),
  //               fontFamily: 'Tajawal'),
  //           labelStyle: TextStyle(
  //               fontSize: 16,
  //               color: const Color(0xff334856),
  //               fontFamily: 'Tajawal'),
  //           alignLabelWithHint: true,
  //         ),
  //         selectedItemBuilder: (BuildContext context) {
  //           return items.map<Widget>((String item) {
  //             return Container(
  //               alignment: Alignment.centerRight,
  //               width: 150,
  //               child: Text(
  //                 item,
  //                 textAlign: TextAlign.end,
  //                 style: TextStyle(
  //                   fontFamily: 'Tajawal',
  //                 ),
  //               ),
  //             );
  //           }).toList();
  //         },
  //         value: type,
  //         items: items.map<DropdownMenuItem<String>>((dropdownMenuItem) {
  //           return DropdownMenuItem(
  //             key: UniqueKey(),
  //             value: dropdownMenuItem,
  //             child: SizedBox(
  //               width: 200.w,
  //               child: Text(
  //                 dropdownMenuItem,
  //                 textAlign: TextAlign.right,
  //                 style: TextStyle(
  //                   fontFamily: 'Tajawal',
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //         onChanged: (value) => setState(() => this.type = value),
  //         validator: (value) => value == null ? 'مطلوب' : null,
  //         style: TextStyle(fontSize: 16, color: const Color(0xff334856)),
  //         icon: Icon(Icons.arrow_drop_down_circle),
  //         hint: Padding(
  //           padding: EdgeInsets.only(top: 5.h),
  //           child: SizedBox(
  //             // width: 125.w,
  //             child: Text(
  //               "اختر نوعًا",
  //               textAlign: TextAlign.right,
  //               style: TextStyle(
  //                 fontFamily: 'Tajawal',
  //               ),
  //             ),
  //           ),
  //         ),
  //         // isExpanded: true,
  //       ));
  // }

  Widget _buildTitle() {
    return TextFormField(
      maxLines: 1,
      maxLength: 30,

      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty)
          return "مطلوب";
        if (!RegExp(r"^[\p{L} ,.'-]*$",
            caseSensitive: false, unicode: true, dotAll: true)
            .hasMatch(value)) return "يجب أن يحتوي على أحرف فقط";
        if (value.length > 30) return "لا يمكن ان يزيد عن 30 حرف ";
      },
      controller: title,
      onFieldSubmitted: (_val) {
        if (_val != null) title.text = _val;
      },

      onChanged: (value) {
        setState( () {
          charLength = value.length;
        },
        );
      },

      showCursor: true,
      cursorColor: const Color(0xdeedd03c),
      style: TextStyle(fontSize: 18, color: const Color(0xff334856)),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        // counterText: '${_enteredText.length.toString()}character(s)',
        contentPadding: EdgeInsets.only(right: 20, top: 15 ),
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
        prefixStyle: TextStyle(fontSize: 15, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        hintText: (type=="مبلغ" || type==null) ?'أدخل عنوان الطلب' : 'أدخل نوع المورد المطلوب',
        labelText: (type=="مبلغ" || type==null) ? 'عنوان الطلب *' : 'نوع المورد *',
        hintStyle: TextStyle(
            fontSize: 13,
            color: const Color(0xffcbcbcc),
            fontFamily: 'Tajawal'),
        labelStyle: TextStyle(
            fontSize: 15,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        // hoverColor: const Color(0xff334856),
      ),
    );
  }

  Widget _buildDetailsFunds() {
    double _value;
    return TextFormField(
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().isEmpty)
          return "مطلوب";
        else {
          _value = double.parse(value);
          if (_value > 50000) return "الآقصى= 50000";
          if (_value < 10) return "الآدنى= 10";
        }
      },
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 20, top: 10),
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
        prefixStyle: TextStyle(
            fontSize: 15,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: '00000',
        labelText: 'المبلغ *',
        hintStyle: TextStyle(
            fontSize: 16,
            color: const Color(0xffcbcbcc),
            fontFamily: 'Tajawal'),
        labelStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
      ],
      controller: _amount,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (_val) {
        if (_val != null) {
          _amount.text = _val;
        }
      }, // onsaved
    );
  }

  Widget _buildDetailsItemsAmount() {
    double _value;
    return TextFormField(
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().isEmpty)
          return "مطلوب";
        else {
          _value = double.parse(value);
          if (_value > 200) return "الآقصى= 200";
          if (_value < 5) return "الآدنى= 5";
        }
      },
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 20, top: 15),
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
        prefixStyle: TextStyle(
            fontSize: 15,
            color: const Color(0xff334856),
            fontFamily: 'Tajawal'),
        hoverColor: const Color(0xff334856),
        alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        hintText: '000',
        labelText: 'الكمية المطلوبة *',
        hintStyle: TextStyle(
            fontSize: 16,
            color: const Color(0xffcbcbcc),
            fontFamily: 'Tajawal'),
        labelStyle: const TextStyle(
            fontSize: 15,
            color: Color(0xff334856),
            fontFamily: 'Tajawal'),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
      ],
      controller: itemsAmount,
      keyboardType: TextInputType.number,
      onSaved: (_val) {
        if (_val != null) {
          itemsAmount.text = _val;
        }
      }, // onsaved
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      maxLength: 150,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.fromLTRB(16, 16, 16, 16),
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
        prefixStyle: TextStyle(fontSize: 18, color: const Color(0xff334856)),
        hoverColor: const Color(0xff334856),
        // alignLabelWithHint: true,
        //border: OutlineInputBorder(),
        // hintText: 'أدخل اسم عائلتك',
        // labelText: 'اسم العائلة',
        // hintStyle: TextStyle(
        //     fontSize: 14,
        //     color: const Color(0xff334856),
        //     fontFamily: 'Tajawal'),
        //
        // labelStyle: TextStyle(
        //     fontSize: 18,
        //     color: const Color(0xff334856),
        //     fontFamily: 'Tajawal'),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(150)
      ],
      controller: description,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      onSaved: (_val) {
        if (_val != null) description.text = _val;
      }, // onsaved
    );
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
        "هل أنت متأكد من رغبتك في\n تعديل الطلب؟",
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
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // Container(
            //   width: portrait == true ? 250.w : 300.w,
            //   child: Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: _buildType(),
            //   ),
            // ),
            // // email container
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: portrait == true ? 250.w : 300.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: _buildTitle(),
                ),
              ),
            ), // password container
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),

              Container(
                width: portrait == true ? 250.w : 300.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "تفاصيل الطلب",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xff334856),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            if (type == "مبلغ")
              Container(
                  width: portrait == true ? 250.w : 300.w,
                  child: Stack(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: _buildDetailsFunds(),
                      ),Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(11, 15, 0, 0),
                          child: Text(
                            'ريال',
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 15,
                              color: const Color(0xffd2d2d2),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                    ],
                  ) ),
            if (type == "موارد")
              Container(
                  width: portrait == true ? 250.w : 300.w,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: _buildDetailsItemsAmount(),
                  ) ),
            if (type != null) // funds container
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),


            Container(
              width: portrait == true ? 250.w : 300.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "وصف إضافي",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xff334856),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    fontSize: 16,
                  ),
                ),

              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Container(
              width: portrait == true ? 265.w : 310.w,
              height: portrait == true ? 140.w : 150.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: _buildDescription(),
              ),),  // mosque name
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
            ),],
        ),
      ),
    );
  }

  void update(String? id) async {
    RequestViewModel requestVM = RequestViewModel();
    // save to db
    // postedBy = id;
    // FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);

    requestVM.postedBy = id;

    var document = await requestVM.userDocument;

    if (document.exists) {
      Map<String, dynamic>? data = document.data();
      requestVM.setMName = data?['mosque_name'];
      requestVM.setMLocation = data?['location'];
      requestVM.setDescription = description.text;
      requestVM.setTitle = title.text;
      requestVM.setType = type;
      requestVM.setUploadTime = time;

      if (type == "مبلغ") {
        amount = int.parse(_amount.text);
        requestVM.setAmount = amount;
      }

      if (type == "موارد") {
        items_amount = int.parse(itemsAmount.text);
        requestVM.setRequested = items_amount;
      }

      await requestVM.update(widget.document.id);

      Snackbar? snackbar;
      String msg = requestVM.message;
      String msgType = requestVM.msgType;

      snackbar = Snackbar(context, msg, msgType);
      snackbar.showToast();

      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => mmHome()), (route) => false);

      _formKey.currentState?.reset();
    } else {
      Snackbar snackbar2 = Snackbar(context, "لا يمكن تعديل الطلب", "fail");
      snackbar2.showToast();
    }
  }
}
