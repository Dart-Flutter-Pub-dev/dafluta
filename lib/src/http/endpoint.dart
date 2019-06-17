import 'package:http/http.dart';

abstract class EndPoint<T> {
  T convert(Response response);

  Future<EndPointResponse> get(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      final response = await client.get(url, headers: headers);
      return EndPointResponse(response: response, value: convert(response));
    } catch (e) {
      return EndPointResponse(exception: e);
    } finally {
      client.close();
    }
  }
}

class EndPointResponse<T> {
  final Response response;
  final T value;
  final dynamic exception;

  EndPointResponse({this.response, this.value, this.exception});

  bool get isSuccessful {
    int firstDigit = int.parse(response.statusCode.toString().substring(0, 1));

    return ((firstDigit == 1) || (firstDigit == 2) || (firstDigit == 3));
  }
}
