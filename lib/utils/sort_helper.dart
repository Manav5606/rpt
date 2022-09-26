class SortWrapper<T> {
  final List<T>? _data;
  List<T>? _sortedData;

  SortWrapper(this._data) {
    _sortedData = List<T>.of(_data!);
  }

  SortWrapper<T> get unsort => SortWrapper<T>(_data);
  List<T> get sorted => _sortedData!;
  List<T> get initialData => _data!;

  List<T> sort(int Function(T a, T b) sortFunction) {
    sorted.sort(sortFunction);
    return sorted;
  }
}
