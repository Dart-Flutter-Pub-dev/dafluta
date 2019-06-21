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
