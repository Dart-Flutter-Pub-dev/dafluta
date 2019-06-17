import 'dart:convert' as Json;
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';

void main() {
  test('get web page', () async {
    var getWebPage = GetWebPage();
    var result = await getWebPage.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isNotEmpty);
  });

  test('get empty', () async {
    var getEmpty = GetEmpty();
    var result = await getEmpty.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isEmpty);
  });

  test('post web page', () async {
    var postSample = PostSample();
    var result = await postSample.call();

    expect(result.response.statusCode, equals(201));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isEmpty);
  });

  test('non existent end point', () async {
    var nonExistent = NonExistentEndPoint();
    var result = await nonExistent.call();

    expect(result.hasFailed, isTrue);
  });
}

class GetWebPage extends ValueEndPoint<WebPage> {
  Future<EndPointResult> call() {
    return super.get('https://demo4798213.mockable.io/webpage');
  }

  @override
  WebPage convert(Response response) {
    return WebPage.json(response.body);
  }
}

class GetEmpty extends EmptyEndPoint {
  Future<EndPointResult> call() {
    return super.get('https://demo4798213.mockable.io/empty');
  }
}

class PostSample extends EmptyEndPoint {
  Future<EndPointResult> call() {
    return super.post('https://demo4798213.mockable.io/post', body: '{}');
  }
}

class NonExistentEndPoint extends EmptyEndPoint {
  static const String URL = 'https://nonexistent.com';

  Future<EndPointResult> call() {
    return super.get(URL);
  }
}

@immutable
class WebPage {
  final String url;

  WebPage(this.url);

  static WebPage json(String json) {
    var data = Json.jsonDecode(json);

    return WebPage(data['url']);
  }
}
