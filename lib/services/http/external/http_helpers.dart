import 'package:http/http.dart';
import 'package:kayta/errors/errors.dart';
import 'package:kayta/errors/http_errors.dart';
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
        return response.bodyBytes.isEmpty == true
            ? null
            : Response.bytes(
                response.bodyBytes,
                200,
                headers: response.headers,
                isRedirect: response.isRedirect,
                persistentConnection: response.persistentConnection,
                reasonPhrase: response.reasonPhrase,
                request: response.request,
              );
      case 204:
        return null;
      case 400:
        if (response.bodyBytes.isEmpty == true) {
          throw GenericError(
            message: response.body,
            type: HttpError.badRequest,
          );
        } else {
          return Response.bytes(
            response.bodyBytes,
            400,
            headers: response.headers,
            isRedirect: response.isRedirect,
            persistentConnection: response.persistentConnection,
            reasonPhrase: response.reasonPhrase,
            request: response.request,
          );
        }
      case 401:
        throw GenericError(
          message: response.body,
          type: HttpError.unauthorized,
        );
      case 403:
        throw GenericError(
          message: response.body,
          type: HttpError.forbidden,
        );

      case 404:
        throw GenericError(
          message: response.body,
          type: HttpError.notFound,
        );
      case 500:
        throw GenericError(
          message: response.body,
          type: HttpError.internalError,
        );
      default:
        throw GenericError(
          type: HttpError.internalError,
        );
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
