

import 'package:kayta/enums/units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayta/extensions/date_time_extensions.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {
  late DateTime data;

  setUp(() {
    initializeDateFormatting('pt_BR');
    data = DateTime(2021, 02, 25, 1, 14, 2, 4);
  });

  test('Retornar a data formatada correta', () {
    String dataFormatada = data.format();

    expect(dataFormatada, '25/02/2021');
  });

  test('Retornar a data formatada correta', () {
    String dataFormatada = data.format(format: 'dd/MM');

    expect(dataFormatada, '25/02');
  });

  test('Retornar a data formatada correta', () {
    String dataFormatada = data.format(format: 'yMMMMEEEEd', locale: 'pt_BR');

    expect(
        dataFormatada.toLowerCase(), 'quinta-feira, 25 de fevereiro de 2021');
  });

  test(
      'Retornar o proximo dia útil corretamente (Quinta -> Sexta | Sexta -> Segunda)',
      () {
    data = data.proximoDiaUtil();
    expect(data.weekday, DateTime.friday);

    data = data.proximoDiaUtil();
    expect(data.weekday, DateTime.monday);
  });

  test('Retornar somente o dia, mês e ano da data', () {
    data = data.somenteData();
    expect(data, DateTime(data.year, data.month, data.day));
  });

  test('Retornar a data mockada com o ano 2050', () {
    data = data.copy(year: 2050);
    expect(data, DateTime(2050, 02, 25, 1, 14, 2, 4));
  });

  test('Retornar a data adicionando 5 dias', () {
    data = data.addDays(5);
    expect(data, data.copy(day: 2));
  });

  test('Retornar a data adicionando 10 dias e sem hora', () {
    data = data.addDays(10, comHora: false);
    expect(data, data.copy(day: 7, hour: 0, microsecond: 0, millisecond: 0, minute: 0, second: 0,));
  });

  test('Retornar a data adicionando 5 meses', () {
    data = data.addMonth(5);
    expect(data, data.copy(month: 7));
  });

  test('Retornar o primeiro dia do mês corretamente', () {
    data = data.primeiroDiaDoMes();
    expect(data, data.copy(day: 1));
  });

  test('Retornar o último dia do mês corretamente', () {
    data = data.ultimoDiaDoMes();
    expect(data, data.copy(day: 28));
  });

  test('Retornar o último dia do mês corretamente', () {
    data = data.copy(month: 3).ultimoDiaDoMes();
    expect(data, data.copy(day: 31));
  });

  group('Test startOf() datetime', () {
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in seconds',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.SECOND)
              .toString(),
          '2019-10-13 13:12:12.000');
    });
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in minutes',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.MINUTE)
              .toString(),
          '2019-10-13 13:12:00.000');
    });
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in hours',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.HOUR)
              .toString(),
          '2019-10-13 13:00:00.000');
    });
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in days',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.DAY)
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in months',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.MONTH)
              .toString(),
          '2019-10-01 00:00:00.000');
    });
    test(
        'test startOf() method with parsing date time should add and return correct start of date time in years',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .startOf(Units.YEAR)
              .toString(),
          '2019-01-01 00:00:00.000');
    });
  });

  group('Test endOf() datetime', () {
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in seconds',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.SECOND)
              .toString(),
          '2019-10-13 13:12:12.999');
    });
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in mintes',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.MINUTE)
              .toString(),
          '2019-10-13 13:12:59.999');
    });
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in hours',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.HOUR)
              .toString(),
          '2019-10-13 13:59:59.999');
    });
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in days',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.DAY)
              .toString(),
          '2019-10-13 23:59:59.999');
    });
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in months',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.MONTH)
              .toString(),
          '2019-10-31 23:59:59.999');
      expect(
          DateTime.parse('2019-02-13 13:12:12')
              .endOf(Units.MONTH)
              .toString(),
          '2019-02-28 23:59:59.999');
      expect(
          DateTime.parse('2016-02-13 13:12:12')
              .endOf(Units.MONTH)
              .toString(),
          '2016-02-29 23:59:59.999');
    });
    test(
        'test endOf() method with parsing date time should add and return correct end of date time in years',
        () {
      expect(
          DateTime.parse('2019-10-13 13:12:12')
              .endOf(Units.YEAR)
              .toString(),
          '2019-12-31 23:59:59.999');
    });
  });

}
