class Enums {
  static T parse<T>(List<T> list, String value, {T defaultValue}) {
    return list.firstWhere(
        (T e) =>
            e.toString().split('.')[1].toLowerCase() == value.toLowerCase(),
        orElse: () => defaultValue);
  }
}
