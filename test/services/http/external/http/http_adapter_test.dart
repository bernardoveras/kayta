import 'package:http/http.dart';
import 'package:kayta/errors/errors.dart';
import 'package:kayta/errors/http_errors.dart';
import 'package:kayta/services/http/external/http_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class UriFake extends Fake implements Uri {}

class ClientSpy extends Mock implements Client {}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late Uri url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = Uri.parse('www.api.com/teste');
    registerFallbackValue<Uri>(Uri());
  });

  group('post', () {
    mockRequest() => when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        );

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() async {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.post(url, body: {"any_key": "any_value"});

      verify(
        () => client.post(
          url,
          body: {
            "any_key": "any_value",
          },
        ),
      ).called(1);
    });

    test('Should call post without body', () async {
      await sut.post(url);

      verify(() => client.post(url)).called(1);
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.post(url);

      expect(response.body, '{"any_key":"any_value"}');
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.post(url);

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.post(url);

      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.post(url);

      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400, body: '');

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.badRequest);
      });
    });

    test('Should return BadRequestError if post returns 400 with data',
        () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.post(url);

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.unauthorized);
      });
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(403);

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.forbidden);
      });
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(404);

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.notFound);
      });
    });

    test('Should return InternalError if post returns 500', () async {
      mockResponse(500);

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });

    test('Should return InternalError if post throws', () async {
      mockError();

      sut.post(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });
  });

  group('get', () {
    mockRequest() => when(
          () => client.get(
            any(),
            headers: any(named: 'headers'),
          ),
        );

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.get(url);

      verify(() => client.get(url)).called(1);

      await sut.get(url, headers: {'any_key': 'any_value'});
      verify(
        () => client.get(url, headers: {'any_key': 'any_value'}),
      ).called(1);
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.get(url);

      expect(response.body, '{"any_key":"any_value"}');
    });

    test('Should return null if get returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400, body: '');

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.badRequest);
      });
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.get(url);

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.unauthorized);
      });
    });

    test('Should return ForbiddenError if get returns 403', () async {
      mockResponse(403);

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.forbidden);
      });
    });

    test('Should return NotFoundError if get returns 404', () async {
      mockResponse(404);

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.notFound);
      });
    });

    test('Should return InternalError if get returns 500', () async {
      mockResponse(500);

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });

    test('Should return InternalError if get throws', () async {
      mockError();

      sut.get(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });
  });

  group('put', () {
    mockRequest() => when(
          () => client.put(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        );

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test('Should call put with correct values', () async {
      await sut.put(url, body: {"any_key": "any_value"});

      verify(
        () => client.put(
          url,
          body: {
            "any_key": "any_value",
          },
        ),
      ).called(1);
    });

    test('Should call put without body', () async {
      await sut.put(url);

      verify(() => client.put(url)).called(1);
    });

    test('Should return data if put returns 200', () async {
      final response = await sut.put(url);

      expect(response.body, '{"any_key":"any_value"}');
    });

    test('Should return null if put returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.put(url);

      expect(response, null);
    });

    test('Should return null if put returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.put(url);

      expect(response, null);
    });

    test('Should return null if put returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.put(url);

      expect(response, null);
    });

    test('Should return BadRequestError if put returns 400', () async {
      mockResponse(400, body: '');

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.badRequest);
      });
    });

    test('Should return BadRequestError if put returns 400', () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.put(url);

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if put returns 401', () async {
      mockResponse(401);

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.unauthorized);
      });
    });

    test('Should return ForbiddenError if put returns 403', () async {
      mockResponse(403);

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.forbidden);
      });
    });

    test('Should return NotFoundError if put returns 404', () async {
      mockResponse(404);

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.notFound);
      });
    });

    test('Should return InternalError if put returns 500', () async {
      mockResponse(500);

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });

    test('Should return InternalError if put throws', () async {
      mockError();

      sut.put(url).catchError((error) {
        if (error is GenericError) expect(error.type, HttpError.internalError);
      });
    });
  });
}
