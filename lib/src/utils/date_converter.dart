import 'package:hijri/hijri_calendar.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'month_utils.dart';

class Hijri {
  //Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)
  late int year;
  late int month;
  late int day;


  // Constructor to initialize Hijri date
  Hijri({required this.year, required this.month, required this.day});

  /// Creates a Hijri instance from today's Gregorian date.
  factory Hijri.now() {
    final hijriToday = HijriCalendar.now();
    return Hijri(
      year: hijriToday.hYear,
      month: hijriToday.hMonth,
      day: hijriToday.hDay,
    );
  }
  /* Converts a given Hijri date (passed as a Hijri object) to Gregorian DateTime.
  /// This is a static method, meaning you don't need an instance to use it.
  /// Usage:
  DateTime gregorian = Hijri.toGregorian(Hijri(year: 1446, month: 1, day: 10));
  */
  static DateTime toGregorian(Hijri date) {
    return HijriCalendar().hijriToGregorian(date.year, date.month, date.day);
  }

  /* Converts the current Hijri instance to Gregorian DateTime.
   Usage:
     Hijri h = Hijri(year: 1446, month: 1, day: 10);
     DateTime gregorian = h.toGreg();
     */
  DateTime toGreg() {
    return HijriCalendar().hijriToGregorian(year, month, day);
  }

  /*// Converts a Gregorian DateTime to Hijri.
  /// This is a static method that returns a new Hijri object.
  /// Usage:
  ///   Hijri h = Hijri.fromGregorian(DateTime.now());
  */
  static Hijri fromGregorian(DateTime date) {
    final hijri = HijriCalendar.fromDate(date);
    return Hijri(year: hijri.hYear, month: hijri.hMonth, day: hijri.hDay);
  }

  /*// Named constructor: creates a Hijri object from a Gregorian DateTime.
  /// Usage:
  ///   Hijri h = Hijri.fromDate(DateTime.now());*/
  Hijri.fromDate(DateTime date)
      : year = HijriCalendar.fromDate(date).hYear,
        month = HijriCalendar.fromDate(date).hMonth,
        day = HijriCalendar.fromDate(date).hDay;
  /// Returns number of days in the month for this instance.
  int monthLength() {
    final hijriCal = HijriCalendar()
      ..hYear = year
      ..hMonth = month;
    return hijriCal.getDaysInMonth(year,month);
  }

  /*// Converts Hijri date to a string in the format 'dd/mm/yyyy (Hijri)'.
  /// Overrides the default toString method.
  /// Usage:
  ///   print(h.hiToString()); → '10/1/1446 (Hijri)'
  @override */

  @override
  String toString() {
    final monthName = (month >= 1 && month <= 12) ? hijriMonthNames[month] : 'غير معروف';
    return '$monthName $day, $year هـ';
  }
  bool isWeekend() => toGreg().weekday >= 6;



}

class Ethiopian {
  late int year;
  late int month;
  late int day;

  Ethiopian(this.year, this.month, this.day);

  /// Creates a Hijri instance from today's Gregorian date.
  factory Ethiopian.now() {
    final ethToday = Ethiopian.fromDate(DateTime.now());
    return Ethiopian(
      ethToday.year,
      ethToday.month,
      ethToday.day,
    );
  }

  /// Converts Ethiopian date to Gregorian DateTime (static)
  static DateTime toGregorian(Ethiopian date) {
    final et = ETDateTime(date.year, date.month, date.day);
    return et.convertToGregorian();
  }

  /// Converts the current instance to Gregorian
  DateTime toGreg() {
    return ETDateTime(year, month, day).convertToGregorian();
  }

  /// Converts Gregorian DateTime to Ethiopian (static)
  static Ethiopian fromGregorian(DateTime gDate) {
    final eth = gDate.convertToEthiopian();
    return Ethiopian(eth.year, eth.month, eth.day);
  }

  /// Constructor: Create Ethiopian date from Gregorian DateTime
  Ethiopian.fromDate(DateTime date)
      : year = date.convertToEthiopian().year,
        month = date.convertToEthiopian().month,
        day = date.convertToEthiopian().day;

  /// String output for readability
  @override
  String toString() {
    final monthName = (month >= 1 && month <= 13) ? ethiopianMonthNames[month] : 'ወሩ አይታወቅም';
    return '$monthName $day, $year ዓ.ም.';
  }

  /// Returns number of days in a given Ethiopian month
  static int getDaysInMonth(int year, int month) {
    if (month >= 1 && month <= 12) {
      return 30;
    } else if (month == 13) {
      return isLeapYear(year) ? 6 : 5;
    } else {
      throw ArgumentError("Invalid Ethiopian month: $month");
    }
  }

  /// Returns number of days in this instance's month
  int monthLength() {
    return Ethiopian.getDaysInMonth(year, month);
  }

  /// Check if Ethiopian year is a leap year (every 4 years).
  static bool isLeapYear(int year) {
    return year % 4 == 3;
  }

  bool isWeekend() => toGreg().weekday >= 6;


}
