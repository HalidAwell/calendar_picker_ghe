import 'package:calendar_picker_ghe/src/utils/date_converter.dart';
import 'package:calendar_picker_ghe/src/utils/eth_calender_table.dart';
import 'package:flutter/material.dart';

import '../src/service/app_localizations.dart';
import '../src/utils/dimension.dart';

Future<Ethiopian?> ethiopianDatePicker({
  required BuildContext context,
  required int initialYear,
  required int firstYear,
  required int lastYear,
  String locale = 'en',
}) async {
  Ethiopian tempSelected = Ethiopian(initialYear, 1, 1);
  final loc = AppLocalizations(Locale(locale));
  return showDialog<Ethiopian>(
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
                  CalendarTableEthiopian(
                    selectedDate: tempSelected,
                    firstYear: firstYear,
                    lastYear: lastYear,
                    onDateSelected: (newDate) {
                      setState(() => tempSelected = newDate);
                    },
                    loc: loc,
                  ),
                  //const SizedBox(height: 10),
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
