import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/app_localizations.dart';
import 'date_converter.dart';
import 'month_utils.dart';
import 'dimension.dart';

class CalendarTableEthiopian extends StatefulWidget {
  final Ethiopian selectedDate;
  final Function(Ethiopian) onDateSelected;
  final int firstYear;
  final int lastYear;
  final AppLocalizations loc;

  const CalendarTableEthiopian({
    super.key,
    required this.selectedDate,
    required this.firstYear,
    required this.lastYear,
    required this.onDateSelected,
    required this.loc,
  });

  @override
  CalendarTableEthiopianState createState() => CalendarTableEthiopianState();
}

class CalendarTableEthiopianState extends State<CalendarTableEthiopian>
    with SingleTickerProviderStateMixin {
  late Ethiopian _currentDisplayDate;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const Color _isSunday = Color(0xFFE74C3C);
  static const Color _todayColor = Color(0xFF3498DB);
  static const Color _selectedColor = Color(0xFF2C3E50);

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

  void _onDateChanged(Ethiopian newDate) {
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
      newMonth = 13;
      newYear -= 1;
    }

    _onDateChanged(Ethiopian(newYear, newMonth, 1));
  }

  void _nextMonth() {
    int newMonth = _currentDisplayDate.month + 1;
    int newYear = _currentDisplayDate.year;

    if (newMonth > 13) {
      newMonth = 1;
      newYear += 1;
    }

    _onDateChanged(Ethiopian(newYear, newMonth, 1));
  }

  void goToToday() {
    final today = Ethiopian.now();
    _onDateChanged(today);
  }

  bool isSameDay(Ethiopian a, Ethiopian b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatFullDate(Ethiopian date) {
    final localizedMonth =
        getLocalizedEthiopianMonthName(widget.loc, date.month);
    return '$localizedMonth ${date.day}, ${date.year}';
  }

  int getEthiopianWeekday(Ethiopian date) {
    // Convert to Gregorian and get weekday (1 = Monday, 7 = Sunday in DateTime)
    final gregorianDate = date.toGreg();
    // Convert DateTime.weekday (1-7 where Monday=1) to Ethiopian weekday (1-7 where Sunday=1)
    // In Ethiopian calendar, Sunday = 1, Monday = 2, ..., Saturday = 7
    final weekday = gregorianDate.weekday;
    // DateTime weekday: Monday=1, Tuesday=2, Wednesday=3, Thursday=4, Friday=5, Saturday=6, Sunday=7
    // Ethiopian weekday: Sunday=1, Monday=2, Tuesday=3, Wednesday=4, Thursday=5, Friday=6, Saturday=7
    if (weekday == 7) return 1; // Sunday
    return weekday + 1;
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
    final tempGregorian = Ethiopian(
      _currentDisplayDate.year,
      _currentDisplayDate.month,
      1,
    ).toGreg();

    final ethStart = Ethiopian.fromDate(tempGregorian);
    final daysInMonth = ethStart.monthLength();
    final firstWeekday = tempGregorian.weekday % 7;
    final todayEth = Ethiopian.now();

    final isToday = (int day) =>
        day == todayEth.day &&
        _currentDisplayDate.month == todayEth.month &&
        _currentDisplayDate.year == todayEth.year;

    List<Widget> dayCells = [];

    for (int i = 0; i < firstWeekday; i++) {
      dayCells.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final eth =
          Ethiopian(_currentDisplayDate.year, _currentDisplayDate.month, day);
      final isSelected = isSameDay(eth, widget.selectedDate);
      final isTodayDate = isToday(day);
      final ethWeekday = getEthiopianWeekday(eth);
      final isSunday = ethWeekday == 1; // Sunday is 1 in Ethiopian calendar
      final isDisabled =
          eth.year < widget.firstYear || eth.year > widget.lastYear;

      dayCells.add(
        GestureDetector(
          onTap: isDisabled ? null : () => widget.onDateSelected(eth),
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
                            .withOpacity(0.3),
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
                          : isSunday
                              ? _isSunday
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
        _buildTodayHeader(context, todayEth),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavButton(
                  Icons.skip_previous,
                  () => _onDateChanged(Ethiopian(_currentDisplayDate.year - 1,
                      _currentDisplayDate.month, 1))),
              _buildNavButton(Icons.chevron_left, _previousMonth),
              Expanded(
                child: Center(
                  child: Text(
                    '${getLocalizedEthiopianMonthName(widget.loc, _currentDisplayDate.month)} ${_currentDisplayDate.year}',
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
                  () => _onDateChanged(Ethiopian(_currentDisplayDate.year + 1,
                      _currentDisplayDate.month, 1))),
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

  Widget _buildTodayHeader(BuildContext context, Ethiopian today) {
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
                widget.loc.ethiopianDatePicker,
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
                color: Colors.white.withOpacity(0.2),
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
                  Text(
                    _formatFullDate(today),
                    style: GoogleFonts.poppins(
                      fontSize: Dimen.fSmall,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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
          final index = entry.key;
          final label = entry.value;
          return Expanded(
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: Dimen.fSmall,
                  fontWeight: FontWeight.w600,
                  color: index == 0 ? _isSunday : Colors.grey.shade600,
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
