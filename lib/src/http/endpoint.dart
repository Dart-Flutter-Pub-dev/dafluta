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

  bool get isSuccessful {
    return (response.statusCode >= 200) && (response.statusCode <= 299);
  }
}
