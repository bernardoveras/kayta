import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:kayta/services/http/errors/http_errors.dart';
import 'package:kayta/services/http/infraestructure/http_client.dart';
import 'package:kayta/services/http/infraestructure/http_methods.dart';
import 'http_helpers.dart';

class HttpAdapter implements IHttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future get(String url, {Map<String,String> headers}) {
    return _request(url, method: HttpMethods.GET, headers: headers);
  }

  @override
  Future post(String url, {dynamic body, Map<String,String> headers}) {
    return _request(url, method: HttpMethods.POST, headers: headers, body: body);
  }

  @override
  Future put(String url, {dynamic body, Map<String,String> headers}) {
    return _request(url, method: HttpMethods.PUT, headers: headers, body: body);
  }

  Future<dynamic> _request(
    String url, {
    @required HttpMethods method,
    dynamic body,
    Map<String,String> headers,
  }) async {
    var response = Response('', 500);
    Future<Response> futureResponse;
    try {
      if (method == HttpMethods.POST) {
        futureResponse = client.post(url, headers: headers, body: body);
      } else if (method == HttpMethods.GET) {
        futureResponse = client.get(url, headers: headers);
      } else if (method == HttpMethods.PUT) {
        futureResponse = client.put(url, headers: headers, body: body);
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(Duration(seconds: 10));
      }
    } catch (error) {
      throw HttpError.internalError;
    }

    return HttpHelpers.handleResponse(response);
  }
}
