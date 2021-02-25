import 'package:test/test.dart';
import 'package:kayta/extensions/date_time_extensions.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {
  DateTime data;

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
}
