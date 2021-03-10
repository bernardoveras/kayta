import 'dart:io';
import 'package:http/http.dart';
import 'package:kayta/errors/errors.dart';
import 'package:kayta/errors/http_errors.dart';
import 'package:kayta/services/http/infraestructure/http_client.dart';
import 'package:kayta/services/http/infraestructure/http_methods.dart';
import 'http_helpers.dart';

class HttpAdapter implements IHttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future get(Uri url, {Map<String, String>? headers, Duration? timeout}) {
    return _request(url,
        method: HttpMethods.GET, headers: headers, timeout: timeout);
  }

  @override
  Future post(Uri url,
      {dynamic? body, Map<String, String>? headers, Duration? timeout}) {
    return _request(url,
        method: HttpMethods.POST,
        headers: headers,
        body: body,
        timeout: timeout);
  }

  @override
  Future put(Uri url,
      {dynamic? body, Map<String, String>? headers, Duration? timeout}) {
    return _request(url,
        method: HttpMethods.PUT,
        headers: headers,
        body: body,
        timeout: timeout);
  }

  Future<dynamic> _request(
    Uri url, {
    required HttpMethods method,
    dynamic? body,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    var response = Response.bytes([], 500);
    Future<Response>? futureResponse;
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
      throw GenericError(message: error.osError?.message);
    } on ArgumentError catch (error) {
      throw GenericError(
        message: error.message ?? '',
        type: HttpError.internalError,
      );
    } catch (error) {
      throw GenericError(
        message: error.toString(),
        type: HttpError.internalError,
      );
    }

    return HttpHelpers.handleResponse(response);
  }
}
