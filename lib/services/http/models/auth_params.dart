import 'package:kayta/extensions/string_extensions.dart';

class AuthParams {
  final String usuario;
  final String senha;
  bool get isValid => !usuario.ehNuloOuVazio && !senha.ehNuloOuVazio;

  AuthParams(this.usuario, this.senha);
}
