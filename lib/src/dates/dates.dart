class Date {
  static String format(DateTime dateTime) => dateTime.toUtc().toIso8601String();

  static DateTime parse(String value) => DateTime.parse(value);
}
