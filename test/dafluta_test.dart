import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
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
