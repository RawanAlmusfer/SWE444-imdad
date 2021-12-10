import 'package:flutter/material.dart';

class TimePicker{
  TimeOfDay? time;

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  Future pickTime(BuildContext context, TimeOfDay? t) async {
    final initialTime = (t == null ? TimeOfDay.now() : t);
    final newTime = await showTimePicker(
        confirmText: "إدخال",
        cancelText: "إلغاء",
        helpText: "أختر تاريخًا",
        hourLabelText: "الساعة",
      minuteLabelText: "الدقيقة",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Color(0xff334856)),
                caption: TextStyle(color: Color(0xff334856)),
                overline: TextStyle(color: Color(0xff334856)),
                subtitle2: TextStyle(color: Color(0xff334856)),
                headline4: TextStyle(color: Color(0xff334856)),
                headline5: TextStyle(color: Color(0xff334856)),
                headline6: TextStyle(color: Color(0xff334856)),
              ),
              colorScheme: ColorScheme.light(
                primary: Color(0xdeedd03c), // header background color
                onPrimary: Color(0xff334856), // header text color
                onSurface: Color(0xff334856),
// body text color
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
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: (time == null)? initialTime: time!,
        errorInvalidText: "الرجاء ادخال توقيت صحيح"
    );


    if (newTime == null) return;

    time = newTime;
  }
}