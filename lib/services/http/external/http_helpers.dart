import 'package:http/http.dart';
import 'package:kayta/services/http/errors/http_errors.dart';
import 'package:kayta/extensions/string_extensions.dart';

class HttpHelpers {
  static Map<String, dynamic> addAuthorization(String usuario, String senha) {
    Map<String, dynamic> list = {
      'header': _createAuthorizationHeader,
      'body': _createAuthorizationBody(usuario, senha),
    };
    return list;
  }

  static dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response?.body?.isEmpty == true
            ? null
            : Response(response.body, 200);
      case 204:
        return null;
      case 400:
        if (response?.body?.isEmpty == true) {
          throw HttpError.badRequest;
        } else {
          return Response(response.body, 400);
        }
        break;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 500:
        throw HttpError.internalError;
      default:
        throw HttpError.internalError;
    }
  }

  static String _createAuthorizationBody(String usuario, String senha) {
    String body =
        "username=$usuario&password=$senha&grant_type=password&compression=gzip&scope=openid profile usuarioXGrupoEmpresa usuario offline_access";
    return body;
  }

  static Map get _createAuthorizationHeader {
    Map<String, String> header = {};
    String str = "client_rsw:secret";

    header = {
      "Authorization": 'Basic ' + str.createBasic64(),
      "Content-type": "application/x-www-form-urlencoded"
    };

    return header;
  }
}
