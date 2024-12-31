extension ListNullExtension<T> on List<T>? {
  void sortAscBy<K extends Comparable<dynamic>>(K Function(T) keySelector) {
    this?.sort((T a, T b) {
      final K keyA = keySelector(a);
      final K keyB = keySelector(b);
      return keyA.compareTo(keyB);
    });
  }

  void sortDescBy<K extends Comparable<dynamic>>(K Function(T) keySelector) {
    this?.sort((T a, T b) {
      final K keyA = keySelector(a);
      final K keyB = keySelector(b);
      return keyB.compareTo(keyA);
    });
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
