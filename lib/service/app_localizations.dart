import 'package:flutter/widgets.dart';
import 'localization_service.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  String get january => _get("january");
  String get february => _get("february");
  String get march => _get("march");
  String get april => _get("april");
  String get may => _get("may");
  String get june => _get("june");
  String get july => _get("july");
  String get august => _get("august");
  String get september => _get("september");
  String get october => _get("october");
  String get november => _get("november");
  String get december => _get("december");

  String get meskerem => _get("meskerem");
  String get tikimt => _get("tikimt");
  String get hidar => _get("hidar");
  String get tahsas => _get("tahsas");
  String get tir => _get("tir");
  String get yekatit => _get("yekatit");
  String get megabit => _get("megabit");
  String get miazia => _get("miazia");
  String get ginbot => _get("ginbot");
  String get sene => _get("sene");
  String get hamle => _get("hamle");
  String get nehasse => _get("nehasse");
  String get pagumen => _get("pagumen");

  String get muharram => _get("muharram");
  String get safar => _get("safar");
  String get rabiAlAwwal => _get("rabiAlAwwal");
  String get rabiAlThani => _get("rabiAlThani");
  String get jumadaAlAwwal => _get("jumadaAlAwwal");
  String get jumadaAlThaniyah => _get("jumadaAlThaniyah");
  String get rajab => _get("rajab");
  String get shaban => _get("shaban");
  String get ramadan => _get("ramadan");
  String get shawwal => _get("shawwal");
  String get dhulQadah => _get("dhulQadah");
  String get dhulHijjah => _get("dhulHijjah");

  String get mon => _get("mon");
  String get tue => _get("tue");
  String get wed => _get("wed");
  String get thu => _get("thu");
  String get fri => _get("fri");
  String get sat => _get("sat");
  String get sun => _get("sun");

  String get gregorianDatePicker => _get("gregorianDatePicker");
  String get ethiopianDatePicker => _get("ethiopianDatePicker");
  String get hijriDatePicker => _get("hijriDatePicker");
  String get today => _get("today");
  String get ok => _get("ok");
  String get cancel => _get("cancel");

  String _get(String key) {
    return LocalizedStrings.get(locale.languageCode, key);
  }
}
