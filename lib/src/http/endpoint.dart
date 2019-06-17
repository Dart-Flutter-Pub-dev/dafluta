import 'dart:convert';

import 'package:http/http.dart';

abstract class ValueEndPoint<T> {
  T convert(Response response);

  Future<EndPointResult> get(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      final response = await client.get(url, headers: headers);
      return EndPointResult(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.post(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.put(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.patch(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult> delete(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      final response = await client.delete(url, headers: headers);
      return EndPointResult(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult(exception: e);
    } finally {
      client.close();
    }
  }
}

abstract class EmptyEndPoint extends ValueEndPoint<Null> {
  @override
  Null convert(Response response) {
    return null;
  }
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

  bool get hasFailed => (exception != null);
}
