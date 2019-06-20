Example:
--------

```dart
var getWebPage = GetWebPage();
var result = await getWebPage.call();

if (result.isSuccessful) {
    print('Result: ${result.value}');
} else if (result.isUnsuccessful) {
    print('Error: ${result.response.statusCode}');
} else if (result.hasFailed) {
    print('Exception: ${result.exception}');
}
```

```dart
class GetWebPage extends ValueEndPoint<WebPage> {
  Future<EndPointResult<WebPage>> call() {
    return super.get('https://foo.com/bar');
  }

  @override
  WebPage convert(Response response) {
    return WebPage.json(response.body);
  }
}
```

```dart
@immutable
class WebPage {
  final String url;

  WebPage(this.url);

  static WebPage json(String json) {
    var data = Json.jsonDecode(json);

    return WebPage(data['url']);
  }
}
```