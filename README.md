# Kayta 
  
Package para uso interno na VVS Sistemas

[![pub package](https://img.shields.io/pub/v/kayta.svg?label=kayta&color=blue)](https://pub.dev/packages/kayta)
[![likes](https://badges.bar/kayta/likes)](https://pub.dev/packages/kayta/score)
[![popularity](https://badges.bar/kayta/popularity)](https://pub.dev/packages/kayta/score)
![building](https://github.com/bernardoveras/kayta/workflows/build/badge.svg)

  # Guide
  - [Instalação](#instalação)
  - [CPF Validator](#cpf-validator)
  - [CNPJ Validator](#cnpj-validator)
  - [DateTime Extensions](#datetime-extensions)
  - [Double Extensions](#double-extensions)
  - [String Extensions](#string-extensions)
  - [TextField Formatter's](#textfield-formatters)

# Instalação

### 1. Como instalar

Adicione o package no `pubspec.yaml`:

```yaml
dependencies:
  kayta: ^1.0.4
```

Importe o package

```dart
import 'package:kayta/kayta.dart';
```

## CPF Validator
  
``` dart  
// Import package  
import 'package:kayta/validators/cpf_validator.dart';

CPFValidator.isValid("334.616.710-02") // true
CPFValidator.isValid("334.616.710-01") // false
CPFValidator.isValid("35999906032") // true
CPFValidator.isValid("35999906031") // false
CPFValidator.isValid("033461671002") // false

// Se você não quiser que o método de validação tire os valores
// Basta usar false no segundo argumento
CPFValidator.isValid("334.616.710-02", false) // false
CPFValidator.isValid("35999906032@mail", false) // false


// Outros métodos utilitários
CPFValidator.format("33461671002") // Result: 334.616.710-02
CPFValidator.strip("334.616.710-02") // Result: 33461671002

// Gerar um CPF, sem formato
CPFValidator.generate() // Result: 33461671002

// Gerar um CPF formatado
CPFValidator.generate(true) // Result: 334.616.710-02 
```  

## CNPJ Validator
  
``` dart  
// Import package  
import 'package:kayta/validators/cnpj_validator.dart'; 
  
CNPJValidator.isValid("12.175.094/0001-19") // true
CNPJValidator.isValid("12.175.094/0001-18") // false
CNPJValidator.isValid("17942159000128") // true
CNPJValidator.isValid("17942159000127") // false
CNPJValidator.isValid("017942159000128") // false

// Se você não quiser que o método de validação tire os valores
// Basta usar false no segundo argumento
CNPJValidator.isValid("12.175.094/0001-19", false) // false
CNPJValidator.isValid("17942159000128@mail", false) // false

// Outros métodos utilitários
CNPJValidator.format("85137090000110") // Result: 85.137.090/0001-10
CNPJValidator.strip("85.137.090/0001-10") // Result: 85137090000110

// Gerar CNPJ, sem formato
CNPJValidator.generate() // Result: 85137090000110

// Gerar CNPJ formatado
CNPJValidator.generate(true) // Result: 85.137.090/0001-10 
```  

## DateTime Extensions
  
``` dart  
// Import package  
import 'package:kayta/extensions/date_time_extensions.dart';


/// [Format]
DateTime(2021, 02, 25).format() // 25/02/2021

// Se você quiser um formato específico
// Basta usar o parâmetro "format"
DateTime(2021, 02, 25).format(format: 'yMMMMEEEEd') // quinta-feira, 25 de fevereiro de 2021

/// [Add day]
DateTime(2021, 02, 25).addDays(2)

// Se você quiser a data sem a hora
// Basta usar o parâmetro "comData"
DateTime(2021, 02, 25).addDays(2, comHora: false)


/// [Add Month]
DateTime(2021, 02, 25).addMonth(2)

/// [Copy DateTime]
DateTime date = DateTime(2021, 02, 25) // 25/02/2021
date.copy(day: 5) // 05/02/2021

```  

## Double Extensions
  
``` dart  
// Import package  
import 'package:kayta/extensions/double_extensions.dart';

/// [Formatter's]
'1200.99'.format() // 1.200,99
'1200.99'.format(pattern: '#,##0') // 1.200,99
'1200.99'.format(locale: 'pt_BR') // 1.200,99

'97.4'.toPercentage() // 97,4%
'97.4'.toPercentage(pattern: '#,##0') // 97,4%
'97.4'.toPercentage(locale: 'pt_BR') // 97,4%

'2000.99'.toCurrency() // 2.000,99
'2000.99'.toCurrency(locale: 'pt_BR') // 2.000,99
'2000.99'.toCurrency(pattern: '#,##0.00') // 2.000,99
```  

## String Extensions
  
``` dart  
// Import package  
import 'package:kayta/extensions/string_extensions.dart';

/// [Validation's]
'email@vvssistemas.com'.isValidEmail // true
'email@vvssistemas'.isValidEmail // false

String value;
value.ehNuloOuVazio // true
''.ehNuloOuVazio // true

/// [Generates]
'usuario:senha'.createBasic64() // dXN1YXJpbzpzZW5oYQ==
// Se quiser adicionar um prefixo
// basta informa-lo no argumento
'usuario:senha'.createBasic64('Basic') // Basic dXN1YXJpbzpzZW5oYQ==
```  

## TextField Formatter's

Basta incluir o formatter que você quer que o campo tenha, na lista de `inputFormatters`:
- `CepInputFormatter()`
- `CnpjInputFormatter()`
- `CpfInputFormatter()`
- `CpfOuCnpjFormatter()`
- `RealInputFormatter()`
- `TelefoneInputFormatter()`

**Para garantir que o campo aceite apenas valores numéricos, utilize em conjunto com o formatter `FilteringTextInputFormatter.digitsOnly`**
``` dart  
// Import package  
import 'package:kayta/formatters/cep_input_formatter.dart';

TextFormField(
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    CepInputFormatter(),
  ],
);
```  