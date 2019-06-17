import 'dart:convert' as Json;
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';

void main() {
  test('value end point', () async {
    var getDog = GetDog();
    var result = await getDog.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isNotEmpty);
  });

  test('empty end point', () async {
    var getNothing = GetNothing();
    var result = await getNothing.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isEmpty);
  });

  test('non existent end point', () async {
    var nonExistent = NonExistentEndPoint();
    var result = await nonExistent.call();

    expect(result.hasFailed, isTrue);
  });
}

class GetDog extends ValueEndPoint<Dog> {
  static const String URL = 'https://dog.ceo/api/breeds/image/random';

  Future<EndPointResult> call() {
    return super.get(URL);
  }

  @override
  Dog convert(Response response) {
    return Dog.json(response.body);
  }
}

class GetNothing extends EmptyEndPoint {
  static const String URL = 'https://testest.free.beeceptor.com/';

  Future<EndPointResult> call() {
    return super.get(URL);
  }
}

class NonExistentEndPoint extends EmptyEndPoint {
  static const String URL = 'https://nonexistent.com';

  Future<EndPointResult> call() {
    return super.get(URL);
  }
}

@immutable
class Dog {
  final String url;

  Dog(this.url);

  static Dog json(String json) {
    var data = Json.jsonDecode(json);

    return Dog(data['message']);
  }
}
