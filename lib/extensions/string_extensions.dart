import 'dart:convert';

extension StringExtensions on String {
  bool get ehNuloOuVazio {
    return this != null && this != "" ? false : true;
  }

  bool get isValidEmail {
    if (this != null)
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(this);

    return false;
  }

  String createBasic64([String prefixText]) {
    var str = this;
    var bytes = utf8.encode(str);
    return prefixText != null ? '$prefixText ' + base64.encode(bytes) : base64.encode(bytes);
  }
}
