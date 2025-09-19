class IterableMap<K, V> extends Iterable<V> {
  final Map<K, V> _map = {};

  List<K> get keys => _map.keys.toList();

  List<V> get list => _map.values.toList();

  bool has(K key) => _map.containsKey(key);

  V get(K key) => _map[key]!;

  void delete(K key) => remove(key, get(key));

  void add(K key, V value) => _map[key] = value;

  void remove(K key, V value) => _map.remove(key);

  void clear() => _map.clear();

  @override
  Iterator<V> get iterator => _map.values.iterator;
}
