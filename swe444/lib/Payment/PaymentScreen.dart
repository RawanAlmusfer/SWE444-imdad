import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/v_feed.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
//import 'package:stripe/StripeGateway.dart';

import 'StripeGateway.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }

  // void payNow() async {
  //   //the amount must be transformed to cents
  //   var  response =
  //   await StripeServices.payNowHandler(amount: (double.parse(_controller.text) * 100.roundToDouble()).toString(), currency: 'USD');
  //
  //   //showSnackBar();
  //
  //   // Snackbar?  snackbar = Snackbar(context, response.message, "pass");
  //   // snackbar.showToast();
  //   print(response.message);
  //
  // }

  void showSnackBar() {
    String? errorMessage = 'عملية الدفع تمت بنجاح';
    Snackbar? snackbar = Snackbar(context, errorMessage, "pass");
    snackbar.showToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(
          top: 0,
          left: 50,
          right: 50,
        ),
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
           child:   Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(

                  showCursor: true,
                  cursorColor: const Color(0xdeedd03c),
                  controller: _controller,
                  decoration: InputDecoration(
                    hoverColor: const Color(0xff334856),
                    alignLabelWithHint: true,

                //  textAlign: TextAlign.end,
                    hintText: '(\$) USD ',
              //    hintTextDirection: TextAlign.left,
                    labelText: 'أدخل المبلغ المراد التبرع به',
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
                  textAlign: TextAlign.left,  ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            RaisedButton(
                onPressed: () async {
                  String description = 'Donation';
                  String amount =
                      (int.parse(_controller.text) * 100).toString();
                  var response = await StripeServices.payNowHandler(
                      amount: amount,
                      currency: 'USD',
                      description: description);
                  print(response.message);

                  // _scaffoldKey.currentState!.showSnackBar(
                  //     new SnackBar(duration: new Duration(seconds: 4), content:
                  //     new Row(
                  //       children: <Widget>[
                  //         new CircularProgressIndicator(),
                  //         new Text("تتم معالجة عملية الدفع ...")
                  //       ],
                  //     ),
                  //     ));
                  // _handleSignIn()
                  //     .whenComplete(() =>
                  //     Navigator.of(context).pushNamed("/Home")
                  // );

                  showAlertDialog(context, response);
                },
                color: const Color(0xdeedd03c),
                child: Text(
                  'ادفع الآن',
                  style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, var response) {
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
        // VolunteerFeed();
//PaymentScreen();
        // Navigator.of(context).pop(context);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PaymentScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
      title: Text(
        "تأكيد عملية الدفع ",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Tajawal",
          color: const Color(0xdeedd03c),
        ),
      ),
      content: Text(
        feedbackResponse(response)!,
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

  String? feedbackResponse(var response) {
    //var response
    if ((response.message) == 'تمت عملية الدفع بنجاح') {
      return "تمت عملية التبرع بنجاح \n  شاكرين لك مساهمتك";
    } else if ((response.message) == 'Transaction canceled' ||
        (response.message) == 'Something went wrong' ||
        (response.message) == "لم تتم عملية التبرع بنجاح") {
      return "لم تتم عملية التبرع بنجاح";
    } else
      return "لم تتم عملية التبرع بنجاح";
  }
}
