import 'package:flutter/material.dart';
import 'package:calendar_picker_ghe/calendar_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// These variables are used to store the returened
  /// value from date pickers for further use

  DateTime? selectedGDate;
  Hijri? selectedHDate;
  Ethiopian? selectedEDate;

  CalendarType selectedCalendarType = CalendarType.gregorian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unified Date Picker')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                /// Show Gregorian date picker
                /// initialYear can be any valid year or use current year
                final result = await showUnifiedDatePicker(
                  context: context,
                  calendarType: CalendarType.gregorian,
                  initialYear: DateTime.now().year,
                  firstYear: 1900,
                  lastYear: 2100,
                  locale: 'ar',
                );
                if (result != null) {
                  setState(() {
                    selectedGDate = result;
                  });
                }
              },
              child: const Text('Pick Gregorian'),
            ),

            // Show Hijri date picker
            ElevatedButton(
              onPressed: () async {
                final result = await showUnifiedDatePicker(
                  context: context,
                  calendarType: CalendarType.hijri,
                  initialYear: Hijri.now().year,
                  firstYear: 1358, // Roughly equivalent to 1940s
                  lastYear: 1500,
                  locale: 'en',
                );
                if (result != null) {
                  setState(() {
                    selectedHDate = result;
                  });
                }
              },
              child: const Text('Pick Hijri'),
            ),

            // Show Ethiopian date picker
            ElevatedButton(
              onPressed: () async {
                final result = await showUnifiedDatePicker(
                  context: context,
                  calendarType: CalendarType.ethiopian,
                  initialYear: Ethiopian.now().year,
                  firstYear: 1900,
                  lastYear: 2100,
                  locale: 'ar',
                );
                if (result != null) {
                  setState(() {
                    selectedEDate = result;
                  });
                }
              },
              child: const Text('Pick Ethiopian'),
            ),

            const SizedBox(height: 20),

            // Display selected Gregorian date
            if (selectedGDate != null)
              Text(
                "Selected: $selectedGDate",
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 5),

            // Display selected Hijri date
            if (selectedHDate != null)
              Text(
                "Selected: ${selectedHDate?.day}-${selectedHDate?.month}-${selectedHDate?.year} H.",
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 5),

            // Display selected Ethiopian date
            if (selectedEDate != null)
              Text(
                "Selected: ${selectedEDate?.day}-${selectedEDate?.month}-${selectedEDate?.year} E.C.",
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
