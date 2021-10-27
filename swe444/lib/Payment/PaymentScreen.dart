import 'package:flutter/material.dart';
import 'package:swe444/Functions/home_screen/v_feed.dart';
import 'package:swe444/Widgets/show_snackbar.dart';
//import 'package:stripe/StripeGateway.dart';

import 'StripeGateway.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var response ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }

  void payNow() async {
    //the amount must be transformed to cents
     response =
    await StripeServices.payNowHandler(amount: '1000', currency: 'USD');
    //showSnackBar();

    // Snackbar?  snackbar = Snackbar(context, response.message, "pass");
    // snackbar.showToast();
    print(response.message);

  }

  void showSnackBar(){
    String? errorMessage='عملية الدفع تمت بنجاح';
    Snackbar?  snackbar = Snackbar(context, errorMessage, "pass");
    snackbar.showToast();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
            onPressed: () {
              payNow();
              showAlertDialog(context);
            },
            child: Text('pay 1000 \$'),


          )


      ),
    );
  }

  showAlertDialog(BuildContext context) async{

    // set up the button
    Widget okButton = TextButton(
      child: Text("موافق",   textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Tajawal",
          color: const Color(0xdeedd03c),
        ),),

      onPressed: () {
       // VolunteerFeed();
//PaymentScreen();
       // Navigator.of(context).pop(context);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaymentScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
 title: Text("تأكيد عملية الدفع ",   textAlign: TextAlign.right,
   style: TextStyle(
     fontFamily: "Tajawal",
     color: const Color(0xdeedd03c),
   ),),

      content: Text(feedbackResponse()!, textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal"),),


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


 String? feedbackResponse() {
    if ((response.message) == 'تمت عملية الدفع بنجاح') {
     return "تمت عملية التبرع بنجاح \n  شاكرين لك مساهمتك";
    }

    else if ((response.message) == 'Transaction canceled' || (response.message)=='Something went wrong' || (response.message)=="لم تتم عملية التبرع بنجاح") {
      return "لم تتم عملية التبرع بنجاح";}

  }
}