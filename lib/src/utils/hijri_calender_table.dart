import 'package:flutter/material.dart';
import 'date_converter.dart'; // your Hijri class
import 'month_utils.dart';

class CalendarTableHijri extends StatelessWidget {
  final Hijri selectedDate;
  final Function(Hijri) onDateSelected;
  final int firstYear;
  final int lastYear;

  const CalendarTableHijri({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.firstYear,
    required this.lastYear,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Get 1st of Hijri month → Gregorian
    final tempGregorian = Hijri(
        year: selectedDate.year,
        month: selectedDate.month,
        day: 1).toGreg();

    final hijriStart = Hijri.fromDate(tempGregorian);
    final daysInMonth = hijriStart.monthLength();
    final firstWeekday = tempGregorian.weekday % 7;

    final todayHijri = Hijri.fromGregorian(DateTime.now());

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekday; i++) {
      dayCells.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final isToday = day == todayHijri.day &&
          selectedDate.month == todayHijri.month &&
          selectedDate.year == todayHijri.year;

      final isSelected = day == selectedDate.day;

      final hijriDate = Hijri(
        year: selectedDate.year,
        month: selectedDate.month,
        day: day,
      );

      final isDisabled = selectedDate.year < firstYear || selectedDate.year > lastYear;

      dayCells.add(
        GestureDetector(
          onTap: isDisabled
              ? null
              : () => onDateSelected(
            Hijri(year: selectedDate.year, month: selectedDate.month, day: day),
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isToday
                  ? Colors.teal
                  : isSelected
                  ? Colors.teal.shade100
                  : hijriDate.isWeekend()
                  ? Colors.orange[100]
                  : null,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isToday || isSelected ? Colors.teal : Colors.transparent,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? Colors.grey
                    : isToday
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    while (dayCells.length < 42) {
      dayCells.add(Container());
    }

    return Column(
      children: [
        _buildTodayHeader(todayHijri),
        const SizedBox(height: 12),
        _buildMonthNavigation(),
        const SizedBox(height: 12),
        _buildWeekdayRow(['أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت']),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 0.5),
          children: List.generate(6, (week) {
            return TableRow(
              children: List.generate(7, (dayOfWeek) {
                final index = week * 7 + dayOfWeek;
                return SizedBox(height: 40, child: dayCells[index]);
              }),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTodayHeader(Hijri today) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left:10, top:2, right: 10, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.teal[500],
          borderRadius: BorderRadius.circular(6),
        ),
        child:Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("منتقي تاريخ التقويم الهجري", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          if (selectedDate.month != today.month || selectedDate.year != today.year) {
            onDateSelected(today);
          }
        },
        child: Row(
            children: [
              const Icon(Icons.today, size: 18, color: Colors.white),
              const SizedBox(width: 6),
              const Text("اليوم:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(width: 6),
              Text(
                today.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),),
        ],),
    );
  }

  Widget _buildWeekdayRow(List<String> labels) {
    return Row(
      children: List.generate(7, (i) {
        return Expanded(
          child: Container(
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: i == 0 ? Colors.red : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMonthNavigation() {

    List<int> yearRange = List.generate(
      lastYear - firstYear + 1,
          (index) => firstYear + index,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _arrowBtn(Icons.keyboard_double_arrow_left, () => _changeYear(-1)),
        _arrowBtn(Icons.chevron_left, () => _changeMonth(-1)),
        const SizedBox(width: 4),
        Text(hijriMonthNames[selectedDate.month], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(width: 6),
        SizedBox(
          width: 70,
          height: 28,
          child: buildDropdown<int>(
            hint: 'Year',
            value: selectedDate.year,
            items: yearRange,
            onChanged: (year) {
              if (year != null) {
                onDateSelected(Hijri(year: year, month: selectedDate.month, day:1));
              }
            },
          ),
        ),
        const SizedBox(width: 4),
        _arrowBtn(Icons.chevron_right, () => _changeMonth(1)),
        _arrowBtn(Icons.keyboard_double_arrow_right, () => _changeYear(1)),
      ],
    );
  }

  void _changeMonth(int offset) {
    int newMonth = selectedDate.month + offset;
    int newYear = selectedDate.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear += 1;
    } else if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    }

    if (newYear < firstYear || newYear > lastYear) return;

    onDateSelected(Hijri(year: newYear, month: newMonth, day: 1));
  }

  void _changeYear(int offset) {
    int newYear = selectedDate.year + offset;
    if (newYear < firstYear || newYear > lastYear) return;

    onDateSelected(Hijri(year: newYear, month: selectedDate.month, day: 1));
  }

  Widget _arrowBtn(IconData icon, VoidCallback onPressed) {
    return IconButton(
      iconSize: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }
}
