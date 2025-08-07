import 'package:flutter/material.dart';
import 'package:calendar_picker_ghe/service/app_localizations.dart';
import 'date_converter.dart';
import 'month_utils.dart';
import 'dimension.dart';

class CalendarTableHijri extends StatelessWidget {
  final Hijri selectedDate;
  final Function(Hijri) onDateSelected;
  final int firstYear;
  final int lastYear;
  final AppLocalizations loc;

  const CalendarTableHijri({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.firstYear,
    required this.lastYear,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Get 1st of Hijri month → Gregorian
    final tempGregorian =
        Hijri(year: selectedDate.year, month: selectedDate.month, day: 1)
            .toGreg();

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

      final isDisabled =
          selectedDate.year < firstYear || selectedDate.year > lastYear;

      dayCells.add(
        GestureDetector(
          onTap: isDisabled
              ? null
              : () => onDateSelected(
                    Hijri(
                        year: selectedDate.year,
                        month: selectedDate.month,
                        day: day),
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
                fontSize: Dimen.fBig,
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
        _buildTodayHeader(context, todayHijri),
        const SizedBox(height: Dimen.spacingMedium),
        _buildMonthNavigation(context),
        const SizedBox(height: Dimen.spacingMedium),
        _buildWeekdayRow(
            [loc.sun, loc.mon, loc.tue, loc.wed, loc.thu, loc.fri, loc.sat]),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 0.5),
          children: List.generate(6, (week) {
            return TableRow(
              children: List.generate(7, (dayOfWeek) {
                final index = week * 7 + dayOfWeek;
                return SizedBox(
                    height: Dimen.isSmall(context)
                        ? Dimen.cellSmall
                        : Dimen.cellMedium,
                    child: dayCells[index]);
              }),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTodayHeader(BuildContext context, Hijri today) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(
        Dimen.isSmall(context) ? Dimen.spacingLarge : Dimen.spacingSmall,
      ),
      decoration: BoxDecoration(
        color: Colors.teal[500],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(loc.hijriDatePicker,
                  style: TextStyle(
                    fontSize: Dimen.fBig,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (selectedDate.month != today.month ||
                  selectedDate.year != today.year) {
                onDateSelected(today);
              }
            },
            child: Row(
              children: [
                const Icon(Icons.today, size: 12, color: Colors.white),
                const SizedBox(width: Dimen.spacingMedium),
                Expanded(
                  child: Wrap(
                    children: [
                      Text('${loc.today} ',
                          style: TextStyle(
                              fontSize: Dimen.fBig,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      //const SizedBox(width: Dimen.spacingMedium),
                      Text(
                        formatFullHijriDate(today),
                        //today.toString(),
                        style: const TextStyle(
                            fontSize: Dimen.fBig, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimen.spacingMedium)
        ],
      ),
    );
  }

  Widget _buildWeekdayRow(List<String> labels) {
    return Row(
      children: List.generate(7, (i) {
        return Expanded(
          child: Container(
            height: Dimen.cellSmall,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: Dimen.fSmall,
                fontWeight: FontWeight.bold,
                color: i == 0 ? Colors.red : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMonthNavigation(BuildContext context) {
    List<int> yearRange = List.generate(
      lastYear - firstYear + 1,
      (index) => firstYear + index,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _arrowBtn(Icons.keyboard_double_arrow_left, () => _changeYear(-1)),
        _arrowBtn(Icons.chevron_left, () => _changeMonth(-1)),
        //const SizedBox(width: Dimen.spacingSmall),
        Expanded(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    getLocalizedHijriMonthName(loc, selectedDate.month),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: Dimen.fMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: Dimen.cellSmall,
                  child: buildDropdown<int>(
                    hint: 'Year',
                    value: selectedDate.year,
                    items: yearRange,
                    onChanged: (year) {
                      if (year != null) {
                        onDateSelected(Hijri(
                          year: year,
                          month: selectedDate.month,
                          day: 1,
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        //const SizedBox(width: Dimen.spacingSmall),
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
      iconSize: 15,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }

  String formatFullHijriDate(Hijri date) {
    final monthName = getLocalizedHijriMonthName(loc, date.month);
    return '$monthName ${date.day}, ${date.year} ';
  }
}
