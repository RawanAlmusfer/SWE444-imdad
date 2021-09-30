import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar{
  BuildContext context;
  String message;

  Snackbar(
      this.context,
      this.message
      );

  void showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message,textAlign: TextAlign.center),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
    );
  }

}