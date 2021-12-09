import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar {
  BuildContext context;
  String message;
  String type;

  Snackbar(this.context, this.message, this.type);

  void showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (type=='success') {
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        content: Text(
          message,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 16, fontFamily: "Tajawal"),
        ),
        margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
            top: Radius.circular(25),
          ),
        ),
      ),
    );}

    else if (type=='fail'){
      scaffold.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
          backgroundColor: const Color(0xB1DE0B0B),
          content: Text(
            message,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, fontFamily: "Tajawal"),
          ),
          margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
              top: Radius.circular(25),
            ),
          ),
        ),
      );
    }
  }
}
