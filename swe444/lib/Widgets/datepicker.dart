import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;



class DatePicker{
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getText2(DateTime day) {
      return DateFormat('MM/dd/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }



  Future pickDate(BuildContext context, DateTime? day) async {
    final initialDate = (day == null ? DateTime.now() : day);
    final newDate = await showDatePicker(
      context: context,
      errorInvalidText: "الرجاء إدخال قيمة صالحة",
      errorFormatText: "الرجاء إدخال قيمة صالحة",
      confirmText: "إدخال",
      cancelText: "إلغاء",
      helpText: "أختر تاريخًا",
      fieldLabelText: "التاريخ:",
      textDirection: ui.TextDirection
          .rtl,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Color(0xff334856)),
            ),
            colorScheme: ColorScheme.light(
              primary: Color(0xdeedd03c), // header background color
              onPrimary: Color(0xff334856), // header text color
              onSurface: Color(0xff334856), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff334856), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) return;

    date = newDate;
    return date;
  }
}