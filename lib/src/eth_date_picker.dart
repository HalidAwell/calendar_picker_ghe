import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/service/app_localizations.dart';
import '../src/utils/date_converter.dart';
import '../src/utils/eth_calender_table.dart';
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
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          width: Platform.isAndroid
              ? MediaQuery.of(context).size.width * 0.9
              : 400,
          constraints: const BoxConstraints(maxWidth: 450),
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
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, null),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            loc.cancel,
                            style: GoogleFonts.poppins(
                              fontSize: Dimen.fMedium,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimen.spacingMedium),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, tempSelected),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            loc.ok,
                            style: GoogleFonts.poppins(
                              fontSize: Dimen.fMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
