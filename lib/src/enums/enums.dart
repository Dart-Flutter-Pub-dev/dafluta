class Enum {
  static T parse<T>(List<T> list, String value, {T defaultValue}) {
    return list.firstWhere(
        (T e) =>
            e.toString().split('.')[1].toLowerCase() == value.toLowerCase(),
        orElse: () => defaultValue);
  }

  static String name(
    Object value, {
    bool uppercase = true,
  }) {
    final String name = value.toString();

    if (uppercase && name.length >= 2) {
      return '${name[0].toUpperCase()}${name.substring(1)}';
    } else if (uppercase && name.isNotEmpty) {
      return '${name[0].toUpperCase()}';
    } else {
      return name;
    }
  }
}
