import 'package:flutter/widgets.dart';
import 'localization_service.dart';

/// Provides localized strings for supported calendar types (Gregorian,
/// Ethiopian, Hijri) and UI elements in multiple languages.
class AppLocalizations {
  /// The locale used to retrieve localized strings.
  final Locale locale;

  /// Creates an [AppLocalizations] instance for the given [locale].
  AppLocalizations(this.locale);

  /// Retrieves the [AppLocalizations] instance from the widget [context].
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  // Gregorian month names
  /// Returns the localized name for January.
  String get january => _get("january");

  /// Returns the localized name for February.
  String get february => _get("february");

  /// Returns the localized name for March.
  String get march => _get("march");

  /// Returns the localized name for April.
  String get april => _get("april");

  /// Returns the localized name for May.
  String get may => _get("may");

  /// Returns the localized name for June.
  String get june => _get("june");

  /// Returns the localized name for July.
  String get july => _get("july");

  /// Returns the localized name for August.
  String get august => _get("august");

  /// Returns the localized name for September.
  String get september => _get("september");

  /// Returns the localized name for October.
  String get october => _get("october");

  /// Returns the localized name for November.
  String get november => _get("november");

  /// Returns the localized name for December.
  String get december => _get("december");

  // Ethiopian month names
  /// Returns the localized name for Meskerem.
  String get meskerem => _get("meskerem");

  /// Returns the localized name for Tikimt.
  String get tikimt => _get("tikimt");

  /// Returns the localized name for Hidar.
  String get hidar => _get("hidar");

  /// Returns the localized name for Tahsas.
  String get tahsas => _get("tahsas");

  /// Returns the localized name for Tir.
  String get tir => _get("tir");

  /// Returns the localized name for Yekatit.
  String get yekatit => _get("yekatit");

  /// Returns the localized name for Megabit.
  String get megabit => _get("megabit");

  /// Returns the localized name for Miazia.
  String get miazia => _get("miazia");

  /// Returns the localized name for Ginbot.
  String get ginbot => _get("ginbot");

  /// Returns the localized name for Sene.
  String get sene => _get("sene");

  /// Returns the localized name for Hamle.
  String get hamle => _get("hamle");

  /// Returns the localized name for Nehasse.
  String get nehasse => _get("nehasse");

  /// Returns the localized name for Pagumen.
  String get pagumen => _get("pagumen");

  // Hijri month names
  /// Returns the localized name for Muharram.
  String get muharram => _get("muharram");

  /// Returns the localized name for Safar.
  String get safar => _get("safar");

  /// Returns the localized name for Rabi' al-Awwal.
  String get rabiAlAwwal => _get("rabiAlAwwal");

  /// Returns the localized name for Rabi' al-Thani.
  String get rabiAlThani => _get("rabiAlThani");

  /// Returns the localized name for Jumada al-Awwal.
  String get jumadaAlAwwal => _get("jumadaAlAwwal");

  /// Returns the localized name for Jumada al-Thaniyah.
  String get jumadaAlThaniyah => _get("jumadaAlThaniyah");

  /// Returns the localized name for Rajab.
  String get rajab => _get("rajab");

  /// Returns the localized name for Sha'ban.
  String get shaban => _get("shaban");

  /// Returns the localized name for Ramadan.
  String get ramadan => _get("ramadan");

  /// Returns the localized name for Shawwal.
  String get shawwal => _get("shawwal");

  /// Returns the localized name for Dhu al-Qadah.
  String get dhulQadah => _get("dhulQadah");

  /// Returns the localized name for Dhu al-Hijjah.
  String get dhulHijjah => _get("dhulHijjah");

  // Weekdays
  /// Returns the localized abbreviation for Monday.
  String get mon => _get("mon");

  /// Returns the localized abbreviation for Tuesday.
  String get tue => _get("tue");

  /// Returns the localized abbreviation for Wednesday.
  String get wed => _get("wed");

  /// Returns the localized abbreviation for Thursday.
  String get thu => _get("thu");

  /// Returns the localized abbreviation for Friday.
  String get fri => _get("fri");

  /// Returns the localized abbreviation for Saturday.
  String get sat => _get("sat");

  /// Returns the localized abbreviation for Sunday.
  String get sun => _get("sun");

  // UI labels
  /// Returns the localized label for the Gregorian date picker.
  String get gregorianDatePicker => _get("gregorianDatePicker");

  /// Returns the localized label for the Ethiopian date picker.
  String get ethiopianDatePicker => _get("ethiopianDatePicker");

  /// Returns the localized label for the Hijri date picker.
  String get hijriDatePicker => _get("hijriDatePicker");

  /// Returns the localized label for "Today".
  String get today => _get("today");

  /// Returns the localized label for "OK" button.
  String get ok => _get("ok");

  /// Returns the localized label for "Cancel" button.
  String get cancel => _get("cancel");

  /// Internal method to retrieve the localized string by [key]
  /// using the current [locale].
  String _get(String key) {
    return LocalizedStrings.get(locale.languageCode, key);
  }
}
