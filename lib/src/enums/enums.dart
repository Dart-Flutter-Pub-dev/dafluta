class Enum {
  static T parse<T>(List<T> list, String value, {T defaultValue}) {
    return list.firstWhere(
        (T e) =>
            e.toString().split('.')[1].toLowerCase() == value.toLowerCase(),
        orElse: () => defaultValue);
  }

  static String name(
    Object value, {
    EnumMode mode = EnumMode.normal,
  }) {
    final String name = value.toString().split('.').last;

    if (mode == EnumMode.lowercase) {
      return name.toLowerCase();
    } else if (mode == EnumMode.uppercase) {
      return name.toUpperCase();
    } else if (mode == EnumMode.capitalize) {
      if (name.length >= 2) {
        return '${name[0].toUpperCase()}${name.substring(1)}';
      } else {
        return name.toUpperCase();
      }
    } else {
      return name;
    }
  }
}

enum EnumMode {
  normal,
  lowercase,
  uppercase,
  capitalize,
}
