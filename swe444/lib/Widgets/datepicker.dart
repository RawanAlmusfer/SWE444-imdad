import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (newDate == null) return;

    date = newDate;
    return date;
  }
}