import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

abstract class ValueEndPoint<T> {
  final bool logging;

  ValueEndPoint({this.logging = true});

  T convert(Response response);

  Future<EndPointResult<T>> get(url, {Map<String, String> headers}) async {
    var logger = HttpLogger(logging);
    var client = CustomClient(logger);

    try {
      var response = await client.get(url, headers: headers);
      logger.response(response);

      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var logger = HttpLogger(logging);
    var client = CustomClient(logger);

    try {
      var response = await client.post(url,
          headers: headers, body: body, encoding: encoding);
      logger.response(response);

      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var logger = HttpLogger(logging);
    var client = CustomClient(logger);

    try {
      var response = await client.put(url,
          headers: headers, body: body, encoding: encoding);
      logger.response(response);

      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var logger = HttpLogger(logging);
    var client = CustomClient(logger);

    try {
      var response = await client.patch(url,
          headers: headers, body: body, encoding: encoding);
      logger.response(response);

      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> delete(url, {Map<String, String> headers}) async {
    var logger = HttpLogger(logging);
    var client = CustomClient(logger);

    try {
      var response = await client.delete(url, headers: headers);
      logger.response(response);

      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }
}

class EmptyEndPoint extends ValueEndPoint<Null> {
  EmptyEndPoint({logging = true}) : super(logging: logging);

  @override
  Null convert(Response response) {
    return null;
  }
}

class CustomClient extends BaseClient {
  final Client _client = Client();
  final HttpLogger _logger;

  CustomClient(this._logger);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    _logger.request(request);
    return _client.send(request);
  }

  @override
  void close() => _client.close();
}

class EndPointResult<T> {
  final Response response;
  final T value;
  final dynamic exception;

  EndPointResult({this.response, this.value, this.exception});

  bool get isSuccessful =>
      (response != null) &&
      (response.statusCode >= 200) &&
      (response.statusCode <= 299);

  bool get isUnsuccessful => (response != null) && (response.statusCode >= 400);

  bool get hasFailed => (exception != null);
}

class HttpLogger {
  final bool enabled;
  DateTime start;
  String tag;

  HttpLogger(this.enabled);

  void request(Request request) {
    if (enabled) {
      start = DateTime.now();
      tag = (1000 + Random().nextInt(9999 - 1000)).toString();

      print(
          '--> ${request.method} ${request.url} (${request.contentLength}-byte body) [$tag]');

      var headers = request.headers;

      for (var header in headers.keys) {
        print('$header: ${headers[header]}');
      }

      if (request.body.isNotEmpty) {
        print(request.body);
      }

      print('--> END [$tag]');
    }
  }

  void response(Response response) {
    if (enabled) {
      var difference = DateTime.now().difference(start);
      print(
          '<-- ${response.statusCode} ${response.reasonPhrase} (${difference.inMilliseconds}ms) [$tag]');

      var headers = response.headers;

      for (var header in headers.keys) {
        print('$header: ${headers[header]}');
      }

      if (response.body.isNotEmpty) {
        print(response.body);
      }

      print('<-- END [$tag]');
    }
  }
}
