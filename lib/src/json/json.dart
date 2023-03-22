import 'dart:convert';

typedef JsonObject = Map<dynamic, dynamic>;

typedef JsonArray = List<JsonObject>;

class Json {
  static JsonObject object(dynamic input) {
    if (input is String) {
      return jsonDecode(input) as JsonObject;
    } else if (input is JsonObject) {
      return input;
    }

    throw Exception('Cannot create JSON object. Invalid input: $input');
  }

  static JsonArray array(dynamic input) {
    if (input is List) {
      final JsonArray array = <JsonObject>[];

      for (final dynamic element in input) {
        final JsonObject object = <dynamic, dynamic>{};

        if (element is Map) {
          for (final MapEntry<dynamic, dynamic> entry in element.entries) {
            object[entry.key.toString()] = entry.value;
          }
        }

        array.add(object);
      }

      return array;
    } else if (input is JsonArray) {
      return input;
    }

    throw Exception('Cannot create JSON array. Invalid input: $input');
  }

  static String encode(dynamic object) => jsonEncode(object);
}

extension JsonObjectTypeExtension on JsonObject {
  bool has(String field) => containsKey(field);

  String? getString(String field) => this[field] as String;

  int? getInt(String field) => this[field] as int;

  double? getDouble(String field) => this[field] as double;

  num? getNum(String field) => this[field] as num;

  bool? getBool(String field) => this[field] as bool;

  JsonObject? getObject(String field) => this[field] as JsonObject;
}

extension JsonArrayTypeExtension on JsonArray {
  JsonObject? getObject(int index) => this[index];
}
