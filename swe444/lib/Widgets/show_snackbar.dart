import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar {
  BuildContext context;
  String message;

  Snackbar(this.context, this.message);

  void showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 15),
        content: Text(
          message,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 16, fontFamily: "Tajawal"),
        ),
        margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
            top: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
