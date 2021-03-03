import 'dart:io';

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
  Future get(String url, {Map<String, String> headers, Duration timeout}) {
    return _request(url,
        method: HttpMethods.GET, headers: headers, timeout: timeout);
  }

  @override
  Future post(String url,
      {dynamic body, Map<String, String> headers, Duration timeout}) {
    return _request(url,
        method: HttpMethods.POST,
        headers: headers,
        body: body,
        timeout: timeout);
  }

  @override
  Future put(String url,
      {dynamic body, Map<String, String> headers, Duration timeout}) {
    return _request(url,
        method: HttpMethods.PUT,
        headers: headers,
        body: body,
        timeout: timeout);
  }

  Future<dynamic> _request(
    String url, {
    @required HttpMethods method,
    dynamic body,
    Map<String, String> headers,
    Duration timeout,
  }) async {
    var response = Response.bytes([], 500);
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
        response =
            await futureResponse.timeout(timeout ?? Duration(seconds: 10));
      }
    } on SocketException catch (error) {
      if (error?.osError?.errorCode == 111 || error?.osError?.errorCode == 7) {
        throw HttpError.addressError;
      }
      throw HttpError.networkError;
    } catch (error) {
      throw HttpError.internalError;
    }

    return HttpHelpers.handleResponse(response);
  }
}
