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

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    time = newTime;
  }
}