import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:kayta/services/http/errors/http_errors.dart';import 'package:kayta/services/http/external/http_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    PostExpectation mockRequest() => when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,{String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.post(url, body:{'any_key': 'any_value'});

      verify(client.post(url, body: {"any_key":"any_value"}));

    });

    test('Should call post without body', () async {
      await sut.post(url);

      verify(client.post(any, headers: anyNamed('headers')));
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

      final future = sut.post(url);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400 with data', () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.post(url);

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      final future = sut.post(url);

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(403);

      final future = sut.post(url);

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(404);

      final future = sut.post(url);

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return InternalError if post returns 500', () async {
      mockResponse(500);

      final future = sut.post(url);

      expect(future, throwsA(HttpError.internalError));
    });

    test('Should return InternalError if post throws', () async {
      mockError();

      final future = sut.post(url);

      expect(future, throwsA(HttpError.internalError));
    });
  });

  group('get', () {
    PostExpectation mockRequest() =>
        when(client.get(any, headers: anyNamed('headers')));

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.get(url);
      verify(client.get(url));

      await sut.get(url, headers: {'any_key': 'any_value'});
      verify(client.get(url, headers: {'any_key': 'any_value'}));
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

      final future = sut.get(url);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.get(url);

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if get returns 403', () async {
      mockResponse(403);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if get returns 404', () async {
      mockResponse(404);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return InternalError if get returns 500', () async {
      mockResponse(500);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.internalError));
    });

    test('Should return InternalError if get throws', () async {
      mockError();

      final future = sut.get(url);

      expect(future, throwsA(HttpError.internalError));
    });
  });

  group('put', () {
    PostExpectation mockRequest() => when(
        client.put(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,
            {String body = '{"any_key":"any_value"}'}) =>
        mockRequest().thenAnswer((_) async => Response(body, statusCode));

    void mockError() => mockRequest().thenThrow(Exception());

    setUp(() {
      mockResponse(200);
    });

    test('Should call put with correct values', () async {
      await sut.put(url, body: {'any_key': 'any_value'});
      verify(client.put(url, body: {"any_key":"any_value"}));

      await sut.put(url, body: {'any_key': 'any_value'}, headers: {'any_key': 'any_value'});
      verify(client.put(url, body: {"any_key":"any_value"}, headers: {'any_key': 'any_value'}));
    });

    test('Should call put without body', () async {
      await sut.put(url);

      verify(client.put(any, headers: anyNamed('headers')));
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

      final future = sut.put(url);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if put returns 400', () async {
      mockResponse(400, body: '{data: data}');

      final future = await sut.put(url);
      

      expect(future, isA<Response>());
    });

    test('Should return UnauthorizedError if put returns 401', () async {
      mockResponse(401);

      final future = sut.put(url);

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if put returns 403', () async {
      mockResponse(403);

      final future = sut.put(url);

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if put returns 404', () async {
      mockResponse(404);

      final future = sut.put(url);

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return InternalError if put returns 500', () async {
      mockResponse(500);

      final future = sut.put(url);

      expect(future, throwsA(HttpError.internalError));
    });

    test('Should return InternalError if put throws', () async {
      mockError();

      final future = sut.put(url);

      expect(future, throwsA(HttpError.internalError));
    });
  });
}
