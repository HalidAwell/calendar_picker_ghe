import 'package:flutter/material.dart';
import './utils/calendar_table.dart';


Future<DateTime?> GregorianDatePicker({
  required BuildContext context,
  required int initialYear,
  required int firstYear,
  required int lastYear,
}) async {
  // Here is intialYear needed
  DateTime tempSelected = DateTime(initialYear, 1, 1);

  final dialogWidth = 250.0;

  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(12),
        content: SizedBox(
          width: dialogWidth,
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
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, null),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: const Text("OK"),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
