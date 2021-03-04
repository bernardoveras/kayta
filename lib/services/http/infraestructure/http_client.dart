

abstract class IHttpClient {
  Future<dynamic> get(Uri url, {Map<String,String> headers, Duration timeout});
  Future<dynamic> post(Uri url, {dynamic body, Map<String,String> headers, Duration timeout});
  Future<dynamic> put(Uri url, {dynamic body, Map<String,String> headers, Duration timeout});
}
