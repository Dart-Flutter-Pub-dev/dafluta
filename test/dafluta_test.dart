import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:dafluta/src/enums/enums.dart';

void main() {
  group('enum', () {
    test('enums', () {
      final Day day1 = dayParser('monday', Day.MONDAY);
      expect(day1, equals(Day.MONDAY));

      final Day day2 = dayParser('xxx', Day.SUNDAY);
      expect(day2, equals(Day.SUNDAY));
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

  const Person(this.name, this.married, this.address, this.subordinates);

  @override
  bool operator ==(dynamic p) =>
      (p.name == name) &&
      (p.married == married) &&
      (p.address == address) &&
      (p.subordinates.length == subordinates.length) &&
      (const DeepCollectionEquality().equals(p.subordinates, subordinates));

  @override
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

  const Address(this.street, this.number);

  @override
  bool operator ==(dynamic p) => (p.street == street) && (p.number == number);

  @override
  int get hashCode => street.hashCode * number.hashCode;
}

// =============================================================================

Day dayParser(String value, Day defaultValue) {
  return Enum.parse(Day.values, value, defaultValue);
}

enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }
