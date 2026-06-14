import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/app_localizations.dart';
import 'date_converter.dart';
import 'month_utils.dart';
import 'dimension.dart';

class CalendarTableHijri extends StatefulWidget {
  final Hijri selectedDate;
  final Function(Hijri) onDateSelected;
  final int firstYear;
  final int lastYear;
  final AppLocalizations loc;

  const CalendarTableHijri({
    super.key,
    required this.selectedDate,
    required this.firstYear,
    required this.lastYear,
    required this.onDateSelected,
    required this.loc,
  });

  @override
  CalendarTableHijriState createState() => CalendarTableHijriState();
}

class CalendarTableHijriState extends State<CalendarTableHijri>
    with SingleTickerProviderStateMixin {
  late Hijri _currentDisplayDate;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const Color _isFriday =
      Color(0xFFE74C3C); // Friday is holy day in Islam

  @override
  void initState() {
    super.initState();
    _currentDisplayDate = widget.selectedDate;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateTransition() {
    _animationController.reset();
    _animationController.forward();
  }

  void _onDateChanged(Hijri newDate) {
    if (newDate.year < widget.firstYear || newDate.year > widget.lastYear)
      return;
    setState(() {
      _currentDisplayDate = newDate;
      _animateTransition();
    });
    widget.onDateSelected(newDate);
  }

  void _previousMonth() {
    int newMonth = _currentDisplayDate.month - 1;
    int newYear = _currentDisplayDate.year;

    if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    }

    _onDateChanged(Hijri(year: newYear, month: newMonth, day: 1));
  }

  void _nextMonth() {
    int newMonth = _currentDisplayDate.month + 1;
    int newYear = _currentDisplayDate.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear += 1;
    }

    _onDateChanged(Hijri(year: newYear, month: newMonth, day: 1));
  }

  void goToToday() {
    final today = Hijri.fromGregorian(DateTime.now());
    _onDateChanged(today);
  }

  bool isSameDay(Hijri a, Hijri b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatFullDate(Hijri date) {
    final localizedMonth = getLocalizedHijriMonthName(widget.loc, date.month);
    return '$localizedMonth ${date.day}, ${date.year} AH';
  }

  int getHijriWeekday(Hijri date) {
    // Convert to Gregorian and get weekday
    final gregorianDate = date.toGreg();
    // In Hijri calendar, Friday is the holy day (weekday 6 in DateTime where Monday=1)
    // Return the actual weekday number for proper Friday detection
    return gregorianDate.weekday;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity != null) {
          if (details.primaryVelocity! > 0)
            _previousMonth();
          else if (details.primaryVelocity! < 0) _nextMonth();
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          final scaleValue = 0.98 + (_scaleAnimation.value * 0.02);
          final opacityValue =
              (0.9 + (_scaleAnimation.value * 0.1)).clamp(0.0, 1.0);

          return Transform.scale(
            scale: scaleValue,
            child: Opacity(
              opacity: opacityValue,
              child: child,
            ),
          );
        },
        child: _buildCalendarContent(context),
      ),
    );
  }

  Widget _buildCalendarContent(BuildContext context) {
    final tempGregorian = Hijri(
      year: _currentDisplayDate.year,
      month: _currentDisplayDate.month,
      day: 1,
    ).toGreg();

    final hijriStart = Hijri.fromDate(tempGregorian);
    final daysInMonth = hijriStart.monthLength();
    final firstWeekday = tempGregorian.weekday % 7;
    final todayHijri = Hijri.fromGregorian(DateTime.now());

    final isToday = (int day) =>
        day == todayHijri.day &&
        _currentDisplayDate.month == todayHijri.month &&
        _currentDisplayDate.year == todayHijri.year;

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekday; i++) {
      dayCells.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final hijri = Hijri(
        year: _currentDisplayDate.year,
        month: _currentDisplayDate.month,
        day: day,
      );
      final isSelected = isSameDay(hijri, widget.selectedDate);
      final isTodayDate = isToday(day);
      final weekday = getHijriWeekday(hijri);
      final isFriday = weekday == 5; // Friday is 5 in DateTime (Monday=1)
      final isDisabled =
          hijri.year < widget.firstYear || hijri.year > widget.lastYear;

      dayCells.add(
        GestureDetector(
          onTap: isDisabled ? null : () => widget.onDateSelected(hijri),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2C3E50),
                        const Color(0xFF34495E)
                      ],
                    )
                  : isTodayDate
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF3498DB),
                            const Color(0xFF5DADE2)
                          ],
                        )
                      : null,
              color: !isSelected && !isTodayDate ? Colors.transparent : null,
              shape: BoxShape.circle,
              boxShadow: isSelected || isTodayDate
                  ? [
                      BoxShadow(
                        color: (isSelected
                                ? const Color(0xFF2C3E50)
                                : const Color(0xFF3498DB))
                            .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: GoogleFonts.poppins(
                  fontSize: Dimen.fMedium,
                  fontWeight: isSelected || isTodayDate
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: isDisabled
                      ? Colors.grey.shade400
                      : isSelected || isTodayDate
                          ? Colors.white
                          : isFriday
                              ? _isFriday
                              : Colors.grey.shade800,
                ),
              ),
            ),
          ),
        ),
      );
    }

    while (dayCells.length < 42) {
      dayCells.add(const SizedBox());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTodayHeader(context, todayHijri),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavButton(
                  Icons.skip_previous,
                  () => _onDateChanged(Hijri(
                      year: _currentDisplayDate.year - 1,
                      month: _currentDisplayDate.month,
                      day: 1))),
              _buildNavButton(Icons.chevron_left, _previousMonth),
              Expanded(
                child: Center(
                  child: Text(
                    '${getLocalizedHijriMonthName(widget.loc, _currentDisplayDate.month)} ${_currentDisplayDate.year}',
                    style: GoogleFonts.poppins(
                      fontSize: Dimen.fSmall,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              _buildNavButton(Icons.chevron_right, _nextMonth),
              _buildNavButton(
                  Icons.skip_next,
                  () => _onDateChanged(Hijri(
                      year: _currentDisplayDate.year + 1,
                      month: _currentDisplayDate.month,
                      day: 1))),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Colors.grey),
        _buildWeekdayRow([
          widget.loc.sun,
          widget.loc.mon,
          widget.loc.tue,
          widget.loc.wed,
          widget.loc.thu,
          widget.loc.fri,
          widget.loc.sat
        ]),
        const Divider(height: 1, thickness: 1, color: Colors.grey),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: 42,
          itemBuilder: (context, index) => dayCells[index],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTodayHeader(BuildContext context, Hijri today) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.teal.shade700, Colors.teal.shade500],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Text(
                widget.loc.hijriDatePicker,
                style: GoogleFonts.poppins(
                  fontSize: Dimen.fMedium,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (_currentDisplayDate.month != today.month ||
                  _currentDisplayDate.year != today.year) {
                goToToday();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.today, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    widget.loc.today,
                    style: GoogleFonts.poppins(
                      fontSize: Dimen.fSmall,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      _formatFullDate(today),
                      style: GoogleFonts.poppins(
                        fontSize: Dimen.fSmall,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Icon(icon, size: 20, color: Colors.grey.shade700),
        ),
      ),
    );
  }

  Widget _buildWeekdayRow(List<String> labels) {
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: labels.asMap().entries.map((entry) {
          //final index = entry.key;
          final label = entry.value;
          // Friday is index 5 (0-based: Sun=0, Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6)
          final isFriday = label == widget.loc.fri;
          return Expanded(
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: Dimen.fSmall,
                  fontWeight: FontWeight.w600,
                  color: isFriday ? _isFriday : Colors.grey.shade600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
