import 'package:calendar_picker_ghe/src/utils/date_converter.dart';
import 'package:flutter/material.dart';
import '../src/service/app_localizations.dart';
import './utils/hijri_calender_table.dart';
import '../src/utils/dimension.dart';

Future<Hijri?> hijriDatePicker({
  required BuildContext context,
  required int intialYear,
  required int firstYear,
  required int lastYear,
  String locale = 'en',
}) async {
  Hijri tempSelected = Hijri(year: intialYear, month: 1, day: 1);
  final loc = AppLocalizations(Locale(locale));
  return showDialog<Hijri>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(
          Dimen.isSmall(context) ? Dimen.spacingSmall : Dimen.spacingLarge,
        ),
        content: SizedBox(
          width: Dimen.isSmall(context)
              ? Dimen.dialogWidthSmall
              : Dimen.dialogWidthLarge,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarTableHijri(
                    selectedDate: tempSelected,
                    firstYear: firstYear,
                    lastYear: lastYear,
                    onDateSelected: (newDate) {
                      setState(() => tempSelected = newDate);
                    },
                    loc: loc,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, null),
                        child: Text(loc.cancel),
                      ),
                      const SizedBox(width: Dimen.spacingMedium),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: Text(loc.ok),
                      ),
                      const SizedBox(width: Dimen.spacingMedium),
                    ],
                  ),
                  const SizedBox(height: Dimen.spacingMedium),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
