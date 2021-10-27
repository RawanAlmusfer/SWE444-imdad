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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeServices.init();
  }

  void payNow() async {
    //the amount must be transformed to cents
    var response =
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

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
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
      title: Text("My title"),
      content: Text("This is my message."),
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