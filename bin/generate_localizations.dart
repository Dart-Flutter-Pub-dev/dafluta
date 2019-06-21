#!/usr/bin/env dart
library generate_localizations;

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

main(List<String> args) async {
  var input = args[0];
  var output = args[1];

  var jsonFiles = getJsonFiles(input);
  var entries = await getEntries(jsonFiles[0]);
  var baseLocalization = getBaseLocalization(entries);
  var concreteLocalizations = [];

  for (var jsonFile in jsonFiles) {
    String filename = basename(jsonFile.path);
    var parts = filename.split('.');

    var entries = await getEntries(jsonFile);
    var concrete = getConcreteLocalization(parts[0].toUpperCase(), entries);
    concreteLocalizations.add(concrete);
  }

  var outputFile = File(output);
  outputFile.writeAsStringSync(baseLocalization);

  for (var concrete in concreteLocalizations) {
    outputFile.writeAsStringSync('\n$concrete', mode: FileMode.APPEND);
  }
}

List<File> getJsonFiles(String root) {
  var folder = Directory(root);
  var contents = folder.listSync(recursive: false, followLinks: false);
  List<File> result = [];

  for (var fileOrDir in contents) {
    if (fileOrDir is File) {
      result.add(File(fileOrDir.path));
    }
  }

  return result;
}

Future<List<LocalizationEntry>> getEntries(File file) async {
  var content = await file.readAsString();
  Map<String, dynamic> json = jsonDecode(content);
  List<LocalizationEntry> entries = [];

  for (var entry in json.keys) {
    entries.add(LocalizationEntry.create(entry, json[entry]));
  }

  return entries;
}

String getBaseLocalization(List<LocalizationEntry> entries) {
  String result = 'class BaseLocalized {\n';

  for (var entry in entries) {
    result += entry.lineBase();
  }

  result += '}\n';

  return result;
}

String getConcreteLocalization(String name, List<LocalizationEntry> entries) {
  String result = 'class ${name}Localized extends BaseLocalized {\n';

  for (var entry in entries) {
    result += entry.lineConcrete();
  }

  result += '}\n';

  return result;
}

class LocalizationEntry {
  final String key;
  final String value;
  final List<String> params;

  LocalizationEntry(this.key, this.value, [this.params = const []]);

  static LocalizationEntry create(String key, String value) {
    RegExp exp = new RegExp(r"\$\{([^\}]+)\}");
    List<String> params =
        exp.allMatches(value).toList().map((r) => r.group(1)).toList();

    for (var param in params) {
      value = value.replaceFirst('\$\{$param\}', '\$$param');
    }

    return LocalizationEntry(key, value, params);
  }

  String lineConcrete() {
    return _line(value);
  }

  String lineBase() {
    return _line('');
  }

  String _line(String value) {
    if (params.isEmpty) {
      return "  String $key = '$value';\n";
    } else {
      return "  String $key(${_parameterList(params)}) => '$value';\n";
    }
  }

  String _parameterList(List<String> parameters) {
    var result = '';

    for (var parameter in parameters) {
      result += result.isEmpty ? '' : ', ';

      result += 'String $parameter';
    }

    return result;
  }
}
