import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    dateRange = newDateRange;
  }
}