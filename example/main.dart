import 'dart:convert';
import 'package:dafluta/src/http/endpoint.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

main() async {
  var getWebPage = GetWebPage();
  var result = await getWebPage.call();

  if (result.isSuccessful) {
    print('Result: ${result.value}');
  } else if (result.isUnsuccessful) {
    print('Error: ${result.response.statusCode}');
  } else if (result.hasFailed) {
    print('Exception: ${result.exception}');
  }
}

class GetWebPage extends ValueEndPoint<WebPage> {
  Future<EndPointResult<WebPage>> call() {
    return super.get('https://foo.com/bar');
  }

  @override
  WebPage convert(Response response) {
    return WebPage.json(response.body);
  }
}

@immutable
class WebPage {
  final String url;

  WebPage(this.url);

  static WebPage json(String json) {
    var data = jsonDecode(json);

    return WebPage(data['url']);
  }
}
