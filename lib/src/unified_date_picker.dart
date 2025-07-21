import 'package:flutter/material.dart';
import 'package:calendar_picker_ghe/calendar_picker.dart';

Future<dynamic> showUnifiedDatePicker({
  required BuildContext context,
  required CalendarType calendarType,
  required int initialYear,
  required int firstYear,
  required int lastYear,
}) {
  switch (calendarType) {
    case CalendarType.gregorian:
      return gregorianDatePicker(
        context: context,
        initialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
    case CalendarType.hijri:
      return hijriDatePicker(
        context: context,
        intialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
    case CalendarType.ethiopian:
      return ethiopianDatePicker(
        context: context,
        initialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
  }
}
