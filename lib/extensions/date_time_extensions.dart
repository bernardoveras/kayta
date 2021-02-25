import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format({String format = 'dd/MM/yyyy', String locale}) {
    DateFormat formatter = DateFormat(format, locale);
    return formatter.format(this);
  }

  DateTime proximoDiaUtil() {
    if (this.weekday == DateTime.saturday) return this.addDays(2);
    if (this.weekday == DateTime.sunday) return this.addDays(1);
    if (this.weekday == DateTime.friday) return this.addDays(3);
    return this.addDays(1);
  }

  DateTime somenteData() => DateTime(this.year, this.month, this.day);

  DateTime addDays(int days, {bool comHora = true}) {
    if (comHora == false) return this.somenteData().add(Duration(days: days));

    return this.add(Duration(days: days));
  }

  DateTime copy(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime addMonth([int months = 1]) => this.copy(month: this.month + months);

  DateTime primeiroDiaDoMes() => this.copy(day: 1);

  DateTime ultimoDiaDoMes() {
    DateTime primeiroDiaDoMes = this.primeiroDiaDoMes();
    DateTime ultimoDiaDoMes = primeiroDiaDoMes.addMonth().addDays(-1);
    return ultimoDiaDoMes;
  }
}
