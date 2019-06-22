import 'dart:convert';

class JsonData {
  final dynamic data;

  JsonData.fromString(String json) : data = jsonDecode(json);

  JsonData.fromMap(this.data);

  String string(String key, {String defaultValue}) {
    return data[key] ?? (defaultValue ?? '');
  }

  int integer(String key, {int defaultValue}) {
    return (data[key] != null) ? (data[key] as int) : defaultValue;
  }

  num number(String key, {num defaultValue}) {
    return (data[key] != null) ? (data[key] as num) : defaultValue;
  }

  bool boolean(String key, {bool defaultValue}) {
    return (data[key] != null) ? (data[key] as bool) : defaultValue;
  }

  List<T> list<T>(String key, T f(JsonData jsonData)) {
    return (data[key] != null)
        ? List.from(data[key]).map((e) => f(JsonData.fromMap(e))).toList()
        : [];
  }

  JsonData object(String key) {
    return (data[key] != null)
        ? JsonData.fromMap(data[key])
        : JsonData.fromString('{}');
  }
}
