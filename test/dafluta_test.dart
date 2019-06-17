import 'dart:convert' as Json;
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';

void main() {
  test('http test', () async {
    var getDog = GetDog();
    var response = await getDog.run();

    if (response.isSuccessful) {
      print('Ok: ${response.response}');
      print('Ok: ${response.value}');
    } else {
      print('Fail: ${response.exception}');
    }
  });
}

class GetDog extends EndPoint<Dog> {
  static const String URL = 'https://dog.ceo/api/breeds/image/random';

  Future<EndPointResponse> run() {
    return super.get(URL);
  }

  @override
  Dog convert(Response response) {
    return Dog.json(response.body);
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
