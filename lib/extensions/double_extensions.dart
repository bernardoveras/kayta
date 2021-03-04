

import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toPercentage({String pattern = '#,##0', String? locale}) {
    return NumberFormat(pattern, locale).format(this) + '%';
  }

  String toCurrency({String pattern = '#,##0.00', String? locale}) {
    return NumberFormat(pattern, locale).format(this);
  }

  String format({required String pattern, String? locale}){
    return NumberFormat(pattern, locale).format(this);
  }
}
