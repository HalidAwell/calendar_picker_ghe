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

  dynamic selectedGDate;
  dynamic selectedHDate;
  dynamic selectedEDate;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    /// As you see here  to use calender pickers from unified
                    /// model call showUnifiedDatePicker by identifing the calender type
                    /// initialYear can be simple (int) year like 2025, forexample, or
                    /// as i use you can assign today's year as shown below.
                    final result = await showUnifiedDatePicker(
                      context: context,
                      calendarType: CalendarType.gregorian,
                      initialYear: DateTime.now().year,
                      firstYear: 1900,
                      lastYear: 2100,
                    );
                    if (result != null) {
                      setState(() {
                        selectedGDate = result;
                      });
                    }
                  },
                  child: const Text('Pick Gregorian'),
                ),
                // this is example for Hijri year.
                ElevatedButton(
                  onPressed: () async {
                    final result = await showUnifiedDatePicker(
                      context: context,
                      calendarType: CalendarType.hijri,
                      initialYear: Hijri.now().year,
                      firstYear: 1358,
                      lastYear: 1500,
                    );
                    if (result != null) {
                      setState(() {
                        selectedHDate = result;
                      });
                    }
                  },
                  child: const Text('Pick Hijri'),
                ),

                /// this is for ethiopian calender picker example.
                ElevatedButton(
                  onPressed: () async {
                    final result = await showUnifiedDatePicker(
                      context: context,
                      calendarType: CalendarType.ethiopian,
                      initialYear: Ethiopian.now().year,
                      firstYear: 1900,
                      lastYear: 2100,
                    );
                    if (result != null) {
                      setState(() {
                        selectedEDate = result;
                      });
                    }
                  },
                  child: const Text('Pick Ethiopian'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (selectedGDate != null)
              Text(
                "Selected: ${selectedGDate}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 5),
            if (selectedHDate != null)
              Text(
                "Selected: ${selectedHDate.toString()}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 5),
            if (selectedEDate != null)
              Text(
                "Selected: ${selectedEDate.toString()}",
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
