import 'package:kayta/errors/http_errors.dart';

abstract class Failure implements Exception {
  String? get message;
  HttpError? get type;
}

class InternalError implements Failure {
  final String? message;
  final HttpError? type;
  InternalError({this.message, this.type});
}

class ServerError implements Failure {
  final String? message;
  final HttpError? type;
  ServerError({this.message, this.type});
}

class GenericError implements Failure {
  final String? message;
  final HttpError? type;

  GenericError({this.message, this.type});
}
