import 'dart:convert';
import 'package:dafluta/src/http/endpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:http/src/response.dart';
import 'package:meta/meta.dart';
import 'package:dafluta/src/enums/enums.dart';
import 'package:dafluta/src/json/json.dart';

void main() {
  group('json', () {
    test('json', () {
      Person person1 = Person.fromJson(JsonData("""{
          "name": "John Doe",
          "married": true,
          "address":
          {
              "street": "Fake street",
              "number": 123
          },
          "subordinates":
          [
            {
              "name": "Sub 1",
              "married": true,
              "address":
              {
                "street": "Fake street",
                "number": 444
              }
            },
            {
              "name": "Sub 2",
              "married": false,
              "address":
              {
                "street": "Fake street",
                "number": 555
              }
            }
          ]
        }"""));

      Person sub1 = Person('Sub 1', true, Address('Fake street', 444), []);
      Person sub2 = Person('Sub 2', false, Address('Fake street', 555), []);
      Person person2 =
          Person('John Doe', true, Address('Fake street', 123), [sub1, sub2]);

      expect(person1 == person2, isTrue);
    });
  });

  group('enum', () {
    test('enums', () {
      var day1 = dayParser('monday');
      expect(day1, equals(Day.MONDAY));

      var day2 = dayParser('xxx');
      expect(day2, equals(null));

      var day3 = dayParser('xxx', defaultValue: Day.SUNDAY);
      expect(day3, equals(Day.SUNDAY));
    });
  });

  group('end points', () {
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
  });
}

// =============================================================================

@immutable
class Person {
  final String name;
  final bool married;
  final Address address;
  final List<Person> subordinates;

  Person(this.name, this.married, this.address, this.subordinates);

  static Person fromJson(JsonData json) => Person(
        json.string('name'),
        json.boolean('married'),
        json.object('address', Address.fromJson),
        json.list('subordinates', Person.fromJson),
      );

  bool operator ==(p) =>
      (p.name == name) &&
      (p.married == married) &&
      (p.address == address) &&
      (p.subordinates.length == subordinates.length) &&
      (DeepCollectionEquality().equals(p.subordinates, subordinates));

  int get hashCode =>
      name.hashCode *
      married.hashCode *
      address.hashCode *
      subordinates.hashCode;
}

@immutable
class Address {
  final String street;
  final int number;

  Address(this.street, this.number);

  static Address fromJson(JsonData json) => Address(
        json.string('street'),
        json.integer('number'),
      );

  bool operator ==(p) => (p.street == street) && (p.number == number);

  int get hashCode => street.hashCode * number.hashCode;
}

// =============================================================================

Day dayParser(String value, {Day defaultValue}) {
  return Enums.parse(Day.values, value, defaultValue: defaultValue);
}

enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

// =============================================================================

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
