class Enums {
  static T? parse<T extends Enum>(dynamic value, List<dynamic> values,
      [T? defaultValue]) {
    for (final dynamic current in values) {
      if (current.code == value) {
        return current;
      }
    }

    return defaultValue;
  }
}
