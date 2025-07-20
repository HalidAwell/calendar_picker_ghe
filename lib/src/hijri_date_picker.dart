import 'package:calendar_picker_ghe/src/utils/date_converter.dart';
import 'package:flutter/material.dart';
import './utils/hijri_calender_table.dart';


Future<Hijri?> HijriDatePicker({
  required BuildContext context,
  required int intialYear,
  required int firstYear,
  required int lastYear,
}) async {
  Hijri tempSelected = Hijri(year: intialYear, month: 1, day: 1);

  final dialogWidth = 250.0;

  return showDialog<Hijri>(
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
                  CalendarTableHijri(
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
                        child: const Text("إلغاء"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: const Text("موافق"),
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
