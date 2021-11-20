import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;


class DateRangePicker{

  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.end);
    }
  }


  Future pickDateRange(BuildContext context, DateTime? start, DateTime? end ) async {
    final initialDateRange = DateTimeRange(
      start: (start == null ? DateTime.now():start),
      end: (end == null ? DateTime.now().add(Duration(hours: 24 * 3)): end),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
        initialEntryMode: DatePickerEntryMode.calendar,
      errorInvalidText: "الرجاء إدخال قيمة صالحة",
      errorFormatText: "الرجاء إدخال قيمة صالحة",
      confirmText: "إدخال",
      cancelText: "إلغاء",
      helpText: "أختر تاريخًا",
      fieldEndLabelText: "الإنتهاء:",
      fieldStartLabelText: "البدء:",
      errorInvalidRangeText: "الرجاء إدخال فترة صالحة",
      saveText: "حفظ",
      textDirection: ui.TextDirection
          .rtl,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: dateRange ?? initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Color(0xff334856)),
              bodyText1: TextStyle(color: Color(0xff334856)),
              bodyText2: TextStyle(color: Color(0xff334856)),
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

    if (newDateRange == null) return;

    dateRange = newDateRange;
  }
}