

import 'package:intl/intl.dart';
import 'package:kayta/enums/units.dart';

extension DateTimeExtension on DateTime {
  String format({String format = 'dd/MM/yyyy', String? locale}) {
    DateFormat formatter = DateFormat(format, locale);
    return formatter.format(this);
  }

  DateTime copy(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
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

  DateTime addDays(int days, {bool comHora = true}) {
    if (comHora == false) return this.somenteData().add(Duration(days: days));
    return this.add(Duration(days: days));
  }

  DateTime addMonth([int months = 1]) => this.copy(month: this.month + months);

  DateTime primeiroDiaDoMes() => DateTime(this.year, this.month);

  DateTime ultimoDiaDoMes() {
    DateTime primeiroDiaDoMes = this.primeiroDiaDoMes();
    DateTime ultimoDiaDoMes = primeiroDiaDoMes.addMonth().addDays(-1);
    return ultimoDiaDoMes;
  }

  DateTime proximoDiaUtil() {
    if (this.weekday == DateTime.saturday) return this.addDays(2);
    if (this.weekday == DateTime.sunday) return this.addDays(1);
    if (this.weekday == DateTime.friday) return this.addDays(3);
    return this.addDays(1);
  }

  DateTime somenteData() => DateTime(this.year, this.month, this.day);

  DateTime startOf(Units units) {
    DateTime _dateTime = this;
    switch (units) {
      case Units.MILLISECOND:
        _dateTime = DateTime(
            _dateTime.year,
            _dateTime.month,
            _dateTime.day,
            _dateTime.hour,
            _dateTime.minute,
            _dateTime.second,
            _dateTime.millisecond);
        break;
      case Units.SECOND:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute, _dateTime.second);
        break;
      case Units.MINUTE:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute);
        break;
      case Units.HOUR:
        _dateTime = DateTime(
            _dateTime.year, _dateTime.month, _dateTime.day, _dateTime.hour);
        break;
      case Units.DAY:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
        break;
      case Units.WEEK:
        var newDate = _dateTime.subtract(Duration(days: day - 1));
        _dateTime = DateTime(newDate.year, newDate.month, newDate.day);
        break;
      case Units.MONTH:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, 1);
        break;
      case Units.YEAR:
        _dateTime = DateTime(_dateTime.year);
        break;
    }
    return _dateTime;
  }

  DateTime endOf(Units units) {
    DateTime _dateTime = this;
    switch (units) {
      case Units.MILLISECOND:
        _dateTime = DateTime(
            _dateTime.year,
            _dateTime.month,
            _dateTime.day,
            _dateTime.hour,
            _dateTime.minute,
            _dateTime.second,
            _dateTime.millisecond);
        break;
      case Units.SECOND:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute, _dateTime.second, 999);
        break;
      case Units.MINUTE:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute, 59, 999);
        break;
      case Units.HOUR:
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, 59, 59, 999);
        break;
      case Units.DAY:
        _dateTime = DateTime(
            _dateTime.year, _dateTime.month, _dateTime.day, 23, 59, 59, 999);
        break;
      case Units.WEEK:
        var newDate = _dateTime.add(Duration(days: DateTime.daysPerWeek - day));
        _dateTime =
            DateTime(newDate.year, newDate.month, newDate.day, 23, 59, 59, 999);
        break;
      case Units.MONTH:
        var date = _daysInMonthArray[_dateTime.month];
        if (_isLeapYear(_dateTime.year) && _dateTime.month == 2) {
          date = 29;
        }
        _dateTime =
            DateTime(_dateTime.year, _dateTime.month, date, 23, 59, 59, 999);
        break;
      case Units.YEAR:
        _dateTime = DateTime(_dateTime.year, 12, 31, 23, 59, 59, 999);
        break;
    }
    return _dateTime;
  }

  static const _daysInMonthArray = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

   int _daysInMonth(int year, int month) {
    var result = _daysInMonthArray[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }

  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

}
