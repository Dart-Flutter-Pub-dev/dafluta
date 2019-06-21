class BaseLocalized {
  String greetings = '';
  String test1 = '';
}

class ENLocalized extends BaseLocalized {
  String greetings = 'Hello, world!';
  String test1 = 'This is a test';
}

class ESLocalized extends BaseLocalized {
  String greetings = 'Hola, mundo!';
  String test1 = 'Esto es una prueba';
}
