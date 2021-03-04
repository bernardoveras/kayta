

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayta/formatters/cep_input_formatter.dart';
import 'package:kayta/formatters/cnpj_input_formatter.dart';
import 'package:kayta/formatters/compound_formatters/compound_formatter.dart';
import 'package:kayta/formatters/compound_formatters/cpf_ou_cpnj_formatter.dart';
import 'package:kayta/formatters/cpf_input_formatter.dart';
import 'package:kayta/formatters/real_input_formatter.dart';
import 'package:kayta/formatters/telefone_input_formatter.dart';

Widget boilerplate(
    TextInputFormatter inputFormatter, TextEditingController textController) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(size: Size(320, 480)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: TextField(
            controller: textController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              inputFormatter,
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('CpfInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CpfInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
  });

  testWidgets('CnpjInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CnpjInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });

  testWidgets('TelefoneInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();

    await tester
        .pumpWidget(boilerplate(TelefoneInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '9912345678');
    expect(textController.text, '(99) 1234-5678');

    await tester
        .pumpWidget(boilerplate(TelefoneInputFormatter(), textController));
    await tester.enterText(find.byType(TextField), '00987654321');

    expect(textController.text, '(00) 98765-4321');
  });

  testWidgets('CepInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(CepInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '12345678');
    expect(textController.text, '12345-678');
  });

  testWidgets('RealInputFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    await tester.pumpWidget(boilerplate(RealInputFormatter(), textController));

    await tester.enterText(find.byType(TextField), '1234');
    expect(textController.text, '1.234');

    await tester.pumpWidget(
        boilerplate(RealInputFormatter(centavos: true), textController));

    await tester.enterText(find.byType(TextField), '5678');
    expect(textController.text, '56,78');
  });

  testWidgets('Compound of CPF and CPNJ', (WidgetTester tester) async {
    final textController = TextEditingController();
    final formatter = CompoundFormatter([
      CpfInputFormatter(),
      CnpjInputFormatter(),
    ]);

    // Esperamos os resultados no seguinte formato:
    // '123.456.789-00'      // CPF
    // '12.345.678/9000-99'  // CPNJ

    await tester.pumpWidget(boilerplate(formatter, textController));
    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
    await tester.enterText(find.byType(TextField), '123456789000');
    expect(textController.text, '12.345.678/9000');
    await tester.enterText(find.byType(TextField), '1234567890009');
    expect(textController.text, '12.345.678/9000-9');
    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });

  testWidgets('CPFToCPNJFormatter', (WidgetTester tester) async {
    final textController = TextEditingController();
    final formatter = CpfOuCnpjFormatter();

    // Esperamos os resultados no seguinte formato:
    // '123.456.789-00'      // CPF
    // '12.345.678/9000-99'  // CPNJ

    await tester.pumpWidget(boilerplate(formatter, textController));
    await tester.enterText(find.byType(TextField), '12345678900');
    expect(textController.text, '123.456.789-00');
    await tester.enterText(find.byType(TextField), '123456789000');
    expect(textController.text, '12.345.678/9000');
    await tester.enterText(find.byType(TextField), '1234567890009');
    expect(textController.text, '12.345.678/9000-9');
    await tester.enterText(find.byType(TextField), '12345678900099');
    expect(textController.text, '12.345.678/9000-99');
  });
}
