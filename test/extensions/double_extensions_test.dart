import 'package:test/test.dart';
import 'package:kayta/extensions/double_extensions.dart';

main() {
  double value;

  setUp((){
    value = 22350.99;
  });

  test('Retornar o número formatado correto', () {
    String numeroFormatado = value.toCurrency(locale: 'pt_BR');

    expect(numeroFormatado, '22.350,99');

    numeroFormatado = value.toPercentage();
    expect(numeroFormatado, '22,351%');
  });

}
