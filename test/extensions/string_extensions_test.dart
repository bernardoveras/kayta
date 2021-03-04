import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:kayta/extensions/string_extensions.dart';

main() {
  late String email;
  late String? stringValue;

  setUp(() {
    stringValue = 'usuario:senha';
    email = faker.internet.email();
  });
  test('Retornar TRUE caso o e-mail for válido', () {
    expect(email.isValidEmail, true);
  });

  test('Retornar FALSE caso o e-mail for inválido', () {
    email = 'teste@teste';

    expect(email.isValidEmail, false);
  });

  test('Retornar Basic64 corretamente', () {
    stringValue = stringValue.createBasic64();
    expect(stringValue, 'dXN1YXJpbzpzZW5oYQ==');

    stringValue = 'usuario:senha'.createBasic64('Basic');
    expect(stringValue, 'Basic dXN1YXJpbzpzZW5oYQ==');

    stringValue = ''.createBasic64();
    expect(stringValue, '');

    stringValue = ' '.createBasic64();
    expect(stringValue, 'IA==');
  });

  test('Retornar booleano na validação do texto corretamente', () {
    expect(stringValue.ehNuloOuVazio, false);

    stringValue = null;
    expect(stringValue.ehNuloOuVazio, true);

    stringValue = '';
    expect(stringValue.ehNuloOuVazio, true);
  });
}
