import 'package:flutter/material.dart';
import 'month_utils.dart';

class CalendarTableGregorian extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final int firstYear;
  final int lastYear;
  const CalendarTableGregorian({
    super.key,
    required this.selectedDate,
    required this.firstYear,
    required this.lastYear,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    final today = DateTime.now();

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekday; i++) {
      dayCells.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final dayDate = DateTime(selectedDate.year, selectedDate.month, day);
      final isToday = _isSameDate(dayDate, today);
      final isSelected = _isSameDate(dayDate, selectedDate);
      final isWeekend = dayDate.weekday == DateTime.saturday ||
          dayDate.weekday == DateTime.sunday;

      final isDisabled = dayDate.year < firstYear || dayDate.year > lastYear;

      dayCells.add(
        GestureDetector(
          //onTap: () => onDateSelected(dayDate),
          onTap: isDisabled ? null : () => onDateSelected(dayDate),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isToday
                  ? Colors.teal
                  : isSelected
                      ? Colors.teal.shade100
                      : isWeekend
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
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTodayHeader(today),
        const SizedBox(height: 12),
        _buildMonthNavigation(),
        const SizedBox(height: 12),
        _buildWeekdayRow(['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']),
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

  Widget _buildTodayHeader(DateTime today) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.teal[500],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Gregorian Date Calender Picker",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (selectedDate.month != today.month ||
                  selectedDate.year != today.year) {
                onDateSelected(DateTime(today.year, today.month, today.day));
              }
            },
            child: Row(
              children: [
                const Icon(Icons.today, size: 18, color: Colors.white),
                const SizedBox(width: 6),
                const Text("Today:",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(width: 6),
                Text(
                  _formatFullDate(today),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatFullDate(DateTime date) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return '${days[date.weekday % 7]}, ${monthNames[date.month]} ${date.day}, ${date.year}';
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

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
        Text('${monthNames[selectedDate.month]}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
                onDateSelected(DateTime(year, selectedDate.month, 1));
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
    final newDate = DateTime(selectedDate.year, selectedDate.month + offset, 1);
    if (newDate.year < firstYear || newDate.year > lastYear) return;
    onDateSelected(newDate);
  }

  void _changeYear(int offset) {
    final newDate = DateTime(
        selectedDate.year + offset, selectedDate.month, selectedDate.day);
    if (newDate.year < firstYear || newDate.year > lastYear) return;
    onDateSelected(newDate);
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
