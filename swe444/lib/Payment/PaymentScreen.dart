import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:swe444/Functions/home_screen/v_feed.dart';
import 'package:swe444/Functions/home_screen/moneyVFeed.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
//import 'package:stripe/StripeGateway.dart';

import 'StripeGateway.dart';


class PaymentScreen extends StatefulWidget {

  static int? vDonatedAmount=0;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   TextEditingController _controller = TextEditingController();
  int isVDonatedPaymentScreen = 0;
  //int? vDonatedAmount=int.parse(_controller.text);

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
                "عملية التبرع بالمال",
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  moneyVFeed(
                                  )));

                   //   Navigator.pop(context);
                    }

                ),
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
      key: _scaffoldKey,
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
                  child: Image.asset('images/money.png')),


              Container(
                child: Directionality(
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
                    textAlign: TextAlign.left,),
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.04,
              ),
              RaisedButton(
                  onPressed: () async {
                   // vDonatedAmount=(int.parse(_controller.text) * 100)*3.75050163;
                    PaymentScreen.vDonatedAmount=int.parse (_controller.text) ;
                int?  inGate= PaymentScreen.vDonatedAmount;
                String? mmEmailToGate=mv_feed.mmEmailDonated;
                String? mmNameToGate=mv_feed.mmNameDonated;
                //   String description = '$mmEmailToGate  لمدير المسجد صاحب البريد الإلكتروني  $mmNameToGate ريال سعودي لصالح المسجد $inGate التبرع بالمبلغ ';
                    List<String>list=["التبرع بالمبلغ $inGate ريال سعودي", " لصالح مسجد $mmNameToGate ", " $mmEmailToGate  لمدير المسجد صاحب البريد الإلكتروني "];
                    var stringList = list.join("");
                    String description = stringList;

                    //convert from USD to saudi Riyal
                    String amount =
                    (int.parse(_controller.text) * 100).toString();

                    var response = await StripeServices.payNowHandler(
                        amount: amount,
                        currency: 'USD',
                        description: description);
                    print(response.message);

                    showAlertDialog(context, response);
                    feedbackResponseDonation(response);
                  },
                  color: const Color(0xdeedd03c),

                  child: Text(
                    'ادفع الآن',
                    style: TextStyle(
                        fontFamily: "Tajawal", color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }


// get donated{
//   if(feedbackResponseDonation)
//   return int.parse(_controller.text) * 100;
//   else return 0;
// }


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
            context, MaterialPageRoute(builder: (context) => moneyVFeed()));
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
     // isVDonatedPaymentScreen=1;

      return "تمت عملية التبرع بنجاح \n  شاكرين لك مساهمتك";
    } else if ((response.message) == 'Transaction canceled' ||
        (response.message) == 'Something went wrong' ||
        (response.message) == "لم تتم عملية التبرع بنجاح") {
    //  isVDonatedPaymentScreen=0;
      return "لم تتم عملية التبرع بنجاح";
    } else{
    //  isVDonatedPaymentScreen=0;
      return "لم تتم عملية التبرع بنجاح";}
  }


int donated(){
  if(isVDonatedPaymentScreen==1){
    isVDonatedPaymentScreen=0;
    return int.parse(_controller.text) * 100;}
  else return 0;
}

int? feedbackResponseDonation(var response) {
  //var response
  if ((response.message) == 'تمت عملية الدفع بنجاح') {
    return 1;
  } else if ((response.message) == 'Transaction canceled' ||
      (response.message) == 'Something went wrong' ||
      (response.message) == "لم تتم عملية التبرع بنجاح") {
    return 0;
  } else
    return 0;
}

}

