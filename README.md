# Kayta 
  
Package para uso interno na VVS Sistemas

[![pub package](https://img.shields.io/pub/v/kayta.svg?label=kayta&color=blue)](https://pub.dev/packages/kayta)
<!-- [![likes](https://badges.bar/kayta/likes)](https://pub.dev/packages/kayta/score) -->
<!-- [![popularity](https://badges.bar/kayta/popularity)](https://pub.dev/packages/kayta/score) -->
![building](https://github.com/bernardoveras/kayta/workflows/build/badge.svg)

# Instalação

### 1. Como instalar

Adicione o package no `pubspec.yaml`:

```yaml
dependencies:
  kayta: ^1.0.0
```

Importe o package

```dart
import 'package:kayta/kayta.dart';
```

## CPF Validator
  
``` dart  
// Import package  
import 'package:kayta/cpf_validator.dart';  
  
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
import 'package:kayta/cnpj_validator.dart';  
  
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