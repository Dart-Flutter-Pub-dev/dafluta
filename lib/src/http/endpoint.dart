import 'package:http/http.dart';

abstract class EndPoint<T> extends EndPointRequest {
  void execute(void success(T result), void error(Response response));
}

class EndPointRequest {
  Future<Response> get(url, {Map<String, String> headers}) async {
    final client = Client();

    try {
      var response = await client.get(url, headers: headers);

      int firstDigit =
          int.parse(response.statusCode.toString().substring(0, 1));

      if ((firstDigit == 1) || (firstDigit == 2) || (firstDigit == 3)) {
        return response;
      } else {
        throw response;
      }
    } on Response catch (_) {
      rethrow;
    } catch (e) {
      throw Response('', 500);
    } finally {
      client.close();
    }
  }
}
