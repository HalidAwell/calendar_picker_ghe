import 'package:flutter/material.dart';
import 'package:calendar_picker_ghe/src/service/app_localizations.dart';

/// Returns the localized Gregorian month name by 1-based index (1–12)
String getLocalizedMonthName(AppLocalizations loc, int monthIndex) {
  const monthKeys = [
    '', // 0-index unused
    'january', 'february', 'march', 'april', 'may', 'june',
    'july', 'august', 'september', 'october', 'november', 'december'
  ];

  if (monthIndex < 1 || monthIndex > 12) return '';
  final key = monthKeys[monthIndex];

  return _getLocalizedMonthString(loc, key, _gregorianMonthMap);
}

/// Returns the localized Ethiopian month name by 1-based index (1–13)
String getLocalizedEthiopianMonthName(AppLocalizations loc, int monthIndex) {
  const monthKeys = [
    '', // 0-index unused
    'meskerem', 'tikimt', 'hidar', 'tahsas', 'tir', 'yekatit',
    'megabit', 'miazia', 'ginbot', 'sene', 'hamle', 'nehasse', 'pagumen',
  ];

  if (monthIndex < 1 || monthIndex > 13) return '';
  final key = monthKeys[monthIndex];

  return _getLocalizedMonthString(loc, key, _ethiopianMonthMap);
}

/// Returns the localized Hijri month name by 1-based index (1–12)
String getLocalizedHijriMonthName(AppLocalizations loc, int monthIndex) {
  const monthKeys = [
    '', // 0-index unused
    'muharram', 'safar', 'rabiAlAwwal', 'rabiAlThani',
    'jumadaAlAwwal', 'jumadaAlThaniyah', 'rajab', 'shaban',
    'ramadan', 'shawwal', 'dhulQadah', 'dhulHijjah',
  ];

  if (monthIndex < 1 || monthIndex > 12) return '';
  final key = monthKeys[monthIndex];

  return _getLocalizedMonthString(loc, key, _hijriMonthMap);
}

String _getLocalizedMonthString(AppLocalizations loc, String key,
    Map<String, String Function(AppLocalizations)> map) {
  final valueGetter = map[key];
  return valueGetter != null ? valueGetter(loc) : key;
}

final Map<String, String Function(AppLocalizations)> _gregorianMonthMap = {
  'january': (loc) => loc.january,
  'february': (loc) => loc.february,
  'march': (loc) => loc.march,
  'april': (loc) => loc.april,
  'may': (loc) => loc.may,
  'june': (loc) => loc.june,
  'july': (loc) => loc.july,
  'august': (loc) => loc.august,
  'september': (loc) => loc.september,
  'october': (loc) => loc.october,
  'november': (loc) => loc.november,
  'december': (loc) => loc.december,
};

final Map<String, String Function(AppLocalizations)> _ethiopianMonthMap = {
  'meskerem': (loc) => loc.meskerem,
  'tikimt': (loc) => loc.tikimt,
  'hidar': (loc) => loc.hidar,
  'tahsas': (loc) => loc.tahsas,
  'tir': (loc) => loc.tir,
  'yekatit': (loc) => loc.yekatit,
  'megabit': (loc) => loc.megabit,
  'miazia': (loc) => loc.miazia,
  'ginbot': (loc) => loc.ginbot,
  'sene': (loc) => loc.sene,
  'hamle': (loc) => loc.hamle,
  'nehasse': (loc) => loc.nehasse,
  'pagumen': (loc) => loc.pagumen,
};

final Map<String, String Function(AppLocalizations)> _hijriMonthMap = {
  'muharram': (loc) => loc.muharram,
  'safar': (loc) => loc.safar,
  'rabiAlAwwal': (loc) => loc.rabiAlAwwal,
  'rabiAlThani': (loc) => loc.rabiAlThani,
  'jumadaAlAwwal': (loc) => loc.jumadaAlAwwal,
  'jumadaAlThaniyah': (loc) => loc.jumadaAlThaniyah,
  'rajab': (loc) => loc.rajab,
  'shaban': (loc) => loc.shaban,
  'ramadan': (loc) => loc.ramadan,
  'shawwal': (loc) => loc.shawwal,
  'dhulQadah': (loc) => loc.dhulQadah,
  'dhulHijjah': (loc) => loc.dhulHijjah,
};

Widget buildDropdown<T>({
  required String hint,
  required T? value,
  required List<T> items,
  required void Function(T?) onChanged,
}) {
  return SizedBox(
    width: 60,
    child: DropdownButtonFormField<T>(
      isExpanded: true,
      value: value,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dropdownColor: Colors.white,
      hint: Text(
        hint,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            '$item',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
