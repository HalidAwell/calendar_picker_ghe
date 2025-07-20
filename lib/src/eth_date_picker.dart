import 'package:calendar_picker_ghe/src/utils/date_converter.dart';
import 'package:calendar_picker_ghe/src/utils/eth_calender_table.dart';
import 'package:flutter/material.dart';

Future<Ethiopian?> EthiopianDatePicker({
  required BuildContext context,
  required int initialYear,
  required int firstYear,
  required int lastYear,
}) async {
  Ethiopian tempSelected = Ethiopian(initialYear, 1, 1);

  final dialogWidth = 250.0;

  return showDialog<Ethiopian>(
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
                  CalendarTableEthiopian(
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
                        child: const Text("ሰርዝ"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: const Text("እሺ"),
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
