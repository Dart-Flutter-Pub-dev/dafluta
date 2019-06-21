import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BaseLocalized {
  String greetings(String parameter) => '';
  String bye(String person, String place) => '';
  String test = '';
}

class ENLocalized extends BaseLocalized {
  String greetings(String parameter) => 'Hello, $parameter!';
  String bye(String person, String place) => 'Goodbye, $person, and enjoy $place!';
  String test = 'This is a test';
}

class ESLocalized extends BaseLocalized {
  String greetings(String parametro) => 'Hola, $parametro!';
  String bye(String person, String place) => 'Adios, $person, y disfruta $place!';
  String test = 'Esto es una prueba';
}

class Localized {
  static BaseLocalized text;

  static List<Locale> locales = localized.keys.map((l) => Locale(l)).toList();

  static Map<String, BaseLocalized> localized = {
    'en': ENLocalized(),
    'es': ESLocalized()
  };

  static void load(Locale locale) {
    text = localized[locale.languageCode];
  }
}

class CustomLocalizationsDelegate extends LocalizationsDelegate {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => Localized.locales
      .map((l) => l.languageCode)
      .contains(locale.languageCode);

  @override
  Future load(Locale locale) {
    Localized.load(locale);
    return SynchronousFuture(Object());
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}