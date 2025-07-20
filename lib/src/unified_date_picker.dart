import 'package:flutter/material.dart';
import 'gregorian_date_picker.dart';
import 'hijri_date_picker.dart';
import 'eth_date_picker.dart';
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
      return GregorianDatePicker(
        context: context,
        initialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
    case CalendarType.hijri:
      return HijriDatePicker(
        context: context,
        intialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
    case CalendarType.ethiopian:
      return EthiopianDatePicker(
        context: context,
        initialYear: initialYear,
        firstYear: firstYear,
        lastYear: lastYear,
      );
  }
}
