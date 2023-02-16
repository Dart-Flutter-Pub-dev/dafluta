class Enums {
  static E? parse<E extends Enum, V>({
    required V value,
    required List<E> list,
    required V Function(E) mapper,
    E? defaultValue,
  }) {
    for (final E element in list) {
      if (mapper(element) == value) {
        return element;
      }
    }

    return defaultValue;
  }
}
