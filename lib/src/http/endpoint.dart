import 'dart:convert';
import 'package:http/http.dart';

abstract class ValueEndPoint<T> {
  T convert(Response response);

  Future<EndPointResult<T>> get(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      final response = await client.get(url, headers: headers);
      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.post(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.put(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final client = Client();

    try {
      final response = await client.patch(url,
          headers: headers, body: body, encoding: encoding);
      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }

  Future<EndPointResult<T>> delete(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      final response = await client.delete(url, headers: headers);
      return EndPointResult<T>(response: response, value: convert(response));
    } catch (e) {
      return EndPointResult<T>(exception: e);
    } finally {
      client.close();
    }
  }
}

class EmptyEndPoint extends ValueEndPoint<Null> {
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

  bool get isUnsuccessful => (response != null) && (response.statusCode >= 400);

  bool get hasFailed => (exception != null);
}
