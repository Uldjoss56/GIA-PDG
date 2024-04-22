import 'package:intl/intl.dart';

final numberFormat = NumberFormat("0000");

final moneyFormat = NumberFormat("#,###", "fr");

final dateFormatDH = DateFormat('dd-MM-yyyy, HH:mm');
final dateFormatH = DateFormat('HH:mm');

final dateFormatD = DateFormat('dd/MM/yyyy');

bool compareDates(DateTime date1, DateTime date2) {
  DateTime dat = DateTime(date1.year, date1.month, date1.day);
  DateTime date = DateTime(date2.year, date2.month, date2.day);
  return date.compareTo(dat) == 1;
}

final weekDays = {
  7: "dim",
  1: "lun",
  2: "mar",
  3: "mer",
  4: "jeu",
  5: "ven",
  6: "sam",
};

final yearMonths = {
  0: "jan",
  1: "fev",
  2: "mars",
  3: "avr",
  4: "mai",
  5: "juin",
  6: "juil",
  7: "aout",
  8: "sept",
  9: "oct",
  10: "nov",
  11: "dec",
};

String dateOtherFormat(DateTime date) {
  return "${weekDays[date.weekday]}, ${date.day} ${yearMonths[date.month - 1]} ${date.year}";
}
