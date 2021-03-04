

import 'package:kayta/formatters/cnpj_input_formatter.dart';
import 'package:kayta/formatters/compound_formatters/compound_formatter.dart';
import 'package:kayta/formatters/cpf_input_formatter.dart';

class CpfOuCnpjFormatter extends CompoundFormatter {
  CpfOuCnpjFormatter()
      : super([
          CpfInputFormatter(),
          CnpjInputFormatter(),
        ]);
}
