#!/usr/bin/env dart
library generate_localizations;

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

main(List<String> args) async {
  var input = args[0];
  var output = args[1];

  var jsonFiles = getJsonFiles(input);
  var groups = await getGroups(jsonFiles);

  generateFile(output, groups);
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

Future<List<LocalizationGroup>> getGroups(List<File> files) async {
  List<LocalizationGroup> groups = [];

  for (var file in files) {
    String filename = basename(file.path);
    var parts = filename.split('.');
    var entries = await getEntries(file);

    groups.add(LocalizationGroup(parts[0].toLowerCase(), entries));
  }

  return groups;
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

void generateFile(String output, List<LocalizationGroup> groups) async {
  var file = SourceFile(output);
  file.clear();

  // imports
  file.write("import 'package:flutter/foundation.dart';\n");
  file.write("import 'package:flutter/widgets.dart';\n");
  file.write('\n');

  // base
  file.write(groups[0].base());

  // concrete
  for (var group in groups) {
    file.write('\n${group.concrete()}');
  }

  // localized
  file.write('\nclass Localized {\n');
  file.write('  static BaseLocalized text;\n');
  file.write('\n');
  file.write(
      '  static List<Locale> locales = localized.keys.map((l) => Locale(l)).toList();\n');
  file.write('\n');
  file.write('  static Map<String, BaseLocalized> localized = {\n');

  for (var i = 0; i < groups.length; i++) {
    var group = groups[i];
    file.write('    ${group.mapEntry()}');

    if (i < (groups.length - 1)) {
      file.write(',\n');
    } else {
      file.write('\n');
    }
  }
  file.write('  };\n');
  file.write('\n');
  file.write('  static void load(Locale locale) {\n');
  file.write('    text = localized[locale.languageCode];\n');
  file.write('  }\n');
  file.write('}\n');

  // delegate
  file.write(
      '\nclass CustomLocalizationsDelegate extends LocalizationsDelegate {\n');
  file.write('  const CustomLocalizationsDelegate();\n');
  file.write('\n');
  file.write('  @override\n');
  file.write('  bool isSupported(Locale locale) => Localized.locales\n');
  file.write('      .map((l) => l.languageCode)\n');
  file.write('      .contains(locale.languageCode);\n');
  file.write('\n');
  file.write('  @override\n');
  file.write('  Future load(Locale locale) {\n');
  file.write('    Localized.load(locale);\n');
  file.write('    return SynchronousFuture(Object());\n');
  file.write('  }\n');
  file.write('\n');
  file.write('  @override\n');
  file.write(
      '  bool shouldReload(CustomLocalizationsDelegate old) => false;\n');
  file.write('}');
}

class LocalizationGroup {
  final String locale;
  final List<LocalizationEntry> entries;

  LocalizationGroup(this.locale, this.entries);

  String name() {
    return locale.toUpperCase();
  }

  String mapEntry() {
    return "'$locale': ${name()}Localized()";
  }

  String base() {
    String result = 'class BaseLocalized {\n';

    for (var entry in entries) {
      result += entry.lineBase();
    }

    result += '}\n';

    return result;
  }

  String concrete() {
    String result = 'class ${name()}Localized extends BaseLocalized {\n';

    for (var entry in entries) {
      result += entry.lineConcrete();
    }

    result += '}\n';

    return result;
  }
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

class SourceFile {
  final File file;

  SourceFile(String path) : file = File(path);

  void clear() {
    file.writeAsStringSync('');
  }

  void write(String content) {
    file.writeAsStringSync(content, mode: FileMode.append);
  }
}
