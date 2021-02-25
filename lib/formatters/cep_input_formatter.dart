import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de CEP ( XXXXX-XXX ).
class CepInputFormatter extends TextInputFormatter {
  /// Define o tamanho máximo do campo.
  final int maxLength = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    if (newTextLength > maxLength) {
      return oldValue;
    }

    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
