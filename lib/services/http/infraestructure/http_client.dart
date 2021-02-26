abstract class IHttpClient {
  Future<dynamic> get(String url, {Map<String,String> headers, Duration timeout});
  Future<dynamic> post(String url, {dynamic body, Map<String,String> headers, Duration timeout});
  Future<dynamic> put(String url, {dynamic body, Map<String,String> headers, Duration timeout});
}
