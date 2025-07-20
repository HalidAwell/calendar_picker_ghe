import 'package:flutter/material.dart';

Widget buildDropdown<T>({
  required String hint,
  required T? value,
  required List<T> items,
  required void Function(T?) onChanged,
}) {
  return SizedBox(
    width: 70,
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
        style: const TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            '$item',
            style: const TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
const List<String> monthNames = [
  '', // 0-index unused
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];
const List<String> ethiopianMonthNames = [
  '',
  'መስከረም', 'ጥቅምት', 'ኅዳር', 'ታህሳስ',
  'ጥር', 'የካቲት', 'መጋቢት', 'ሚያዚያ',
  'ግንቦት', 'ሰኔ', 'ሀምሌ', 'ነሐሴ', 'ጳጉሜን'
];

const List<String> hijriMonthNames = [
  '', // Index 0 not used
  'مُحَرَّم',
  'صَفَر',
  'رَبِيع ٱلْأَوَّل',
  'رَبِيع ٱلثَّانِي',
  'جُمَادَى ٱلْأُولَى',
  'جُمَادَى ٱلثَّانِيَة',
  'رَجَب',
  'شَعْبَان',
  'رَمَضَان',
  'شَوَّال',
  'ذُو ٱلْقَعْدَة',
  'ذُو ٱلْحِجَّة',
];
