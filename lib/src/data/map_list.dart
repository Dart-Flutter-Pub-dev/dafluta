class MapList<K, V> {
  final Map<K, List<V>> _data = <K, List<V>>{};

  List<K> get keys => _data.keys.toList();

  bool get isEmpty => _data.isEmpty;

  bool get isNotEmpty => _data.isNotEmpty;

  bool has(K key) => _data.containsKey(key);

  void delete(K key) => _data.remove(key);

  void set(K key, List<V> value) {
    _data[key] = value;
  }

  void add(K key, V value) {
    if (_data.containsKey(key)) {
      _data[key]!.add(value);
    } else {
      _data[key] = <V>[value];
    }
  }

  void remove(K key, V value) {
    if (_data.containsKey(key)) {
      _data[key]!.remove(value);

      if (_data[key]!.isEmpty) {
        _data.remove(key);
      }
    }
  }

  List<V> get(K key) {
    if (_data.containsKey(key)) {
      return _data[key]!;
    } else {
      return <V>[];
    }
  }

  void clear() => _data.clear();
}
