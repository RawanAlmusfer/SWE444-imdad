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
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: (time == null)? initialTime: time!,
        errorInvalidText: "الرجاء ادخال توقيت صحيح"
    );


    if (newTime == null) return;

    time = newTime;
  }
}