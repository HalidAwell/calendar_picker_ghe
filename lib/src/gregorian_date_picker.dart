import 'package:flutter/material.dart';

import '../src/service/app_localizations.dart';
import './utils/calendar_table.dart';
import '../src/utils/dimension.dart';

Future<DateTime?> gregorianDatePicker({
  required BuildContext context,
  required int initialYear,
  required int firstYear,
  required int lastYear,
  String locale = 'en', // <-- add this
}) async {
  DateTime tempSelected = DateTime(initialYear, 1, 1);
  final loc = AppLocalizations(Locale(locale));
  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(
            Dimen.isSmall(context) ? Dimen.spacingSmall : Dimen.spacingLarge),
        content: SizedBox(
          width: Dimen.isSmall(context)
              ? Dimen.dialogWidthSmall
              : Dimen.dialogWidthLarge,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarTableGregorian(
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
