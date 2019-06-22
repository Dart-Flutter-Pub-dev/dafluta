import 'dart:convert';

class JsonData {
  final Map<String, dynamic> data;

  JsonData(String json) : data = jsonDecode(json);

  JsonData.fromMap(this.data);

  String string(String key, {String defaultValue = ''}) {
    return (data[key] != null) ? (data[key] as String) : defaultValue;
  }

  int integer(String key, {int defaultValue = 0}) {
    return (data[key] != null) ? (data[key] as int) : defaultValue;
  }

  double decimal(String key, {double defaultValue = 0}) {
    return (data[key] != double) ? (data[key] as double) : defaultValue;
  }

  num number(String key, {num defaultValue = 0}) {
    return (data[key] != null) ? (data[key] as num) : defaultValue;
  }

  bool boolean(String key, {bool defaultValue = false}) {
    return (data[key] != null) ? (data[key] as bool) : defaultValue;
  }

  List<T> list<T>(String key, T f(JsonData jsonData),
      {List<T> defaultValue = const []}) {
    return (data[key] != null)
        ? List.from(data[key]).map((e) => f(JsonData.fromMap(e))).toList()
        : defaultValue;
  }

  T object<T>(String key, T f(JsonData jsonData), {T defaultValue}) {
    return (data[key] != null) ? f(JsonData.fromMap(data[key])) : defaultValue;
  }
}
