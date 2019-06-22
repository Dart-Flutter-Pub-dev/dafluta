import 'dart:convert';
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';
import 'package:dafluta/src/enums/enums.dart';
import 'package:dafluta/src/json/json.dart';

void main() {
  testJson();
  testEnums();
  testEndPoints();
}

// =============================================================================

void testJson() {
  test('json', () {
    Person person1 = Person.fromJson(JsonData.fromString(
        '{"name": "John Doe", "married": true, "address": {"street": "Fake street", "number": 123}}'));
    Person person2 = Person('John Doe', true, Address('Fake street', 123));

    expect(person1 == person2, isTrue);
  });
}

@immutable
class Person {
  final String name;
  final bool married;
  final Address address;

  Person(this.name, this.married, this.address);

  factory Person.fromJson(JsonData json) => Person(
        json.string('name'),
        json.boolean('married'),
        Address.fromJson(json.object('address')),
      );

  bool operator ==(p) =>
      (p.name == name) && (p.married == married) && (p.address == address);

  int get hashCode => name.hashCode * married.hashCode * address.hashCode;
}

@immutable
class Address {
  final String street;
  final num number;

  Address(this.street, this.number);

  factory Address.fromJson(JsonData json) => Address(
        json.string('street'),
        json.number('number'),
      );

  bool operator ==(p) => (p.street == street) && (p.number == number);

  int get hashCode => street.hashCode * number.hashCode;
}

// =============================================================================

void testEnums() {
  test('enums', () {
    var day1 = dayParser('monday');
    expect(day1, equals(Day.MONDAY));

    var day2 = dayParser('xxx');
    expect(day2, equals(null));

    var day3 = dayParser('xxx', defaultValue: Day.SUNDAY);
    expect(day3, equals(Day.SUNDAY));
  });
}

Day dayParser(String value, {Day defaultValue}) {
  return Enums.parse(Day.values, value, defaultValue: defaultValue);
}

enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

// =============================================================================

void testEndPoints() {
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

  test('put web page', () async {
    var putSample = PutSample();
    var result = await putSample.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isEmpty);
  });

  test('patch web page', () async {
    var patchSample = PatchSample();
    var result = await patchSample.call();

    expect(result.response.statusCode, equals(200));
    expect(result.isSuccessful, isTrue);
    expect(result.response.body, isEmpty);
  });

  test('delete web page', () async {
    var deleteSample = DeleteSample();
    var result = await deleteSample.call();

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

class GetWebPage extends ValueEndPoint<WebPage> {
  Future<EndPointResult<WebPage>> call() {
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

class PutSample extends EmptyEndPoint {
  Future<EndPointResult> call() {
    return super.put('https://demo4798213.mockable.io/put', body: '{}');
  }
}

class PatchSample extends EmptyEndPoint {
  Future<EndPointResult> call() {
    return super.patch('https://demo4798213.mockable.io/patch', body: '{}');
  }
}

class DeleteSample extends EmptyEndPoint {
  Future<EndPointResult> call() {
    return super.delete('https://demo4798213.mockable.io/delete');
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
    var data = jsonDecode(json);

    return WebPage(data['url']);
  }
}
