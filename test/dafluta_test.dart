import 'dart:io';
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test('http test', () {
    var getDog = GetDog();
    getDog.execute((result) {
      print(result);
    }, (error) {
      print(error);
    });

    sleep(Duration(seconds: 5));
  });
}

class GetDog extends EndPoint<String> {
  static const String URL = 'https://dog.ceo/api/breeds/image/random';

  @override
  void execute(void success(String dog), void error(Response response)) async {
    try {
      var response = await super.get(URL);
      success(response.body);
    } on Response catch (e) {
      error(e);
    }
  }
}
