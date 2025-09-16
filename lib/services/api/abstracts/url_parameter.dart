class UrlParameter {
  ///
  /// TODO:
  ///
  int? _limit;
  int? get limit => _limit ?? 10;
  void setLimit({required int? value}) {
    _limit = value;
  }

  ///
  /// TODO:
  ///
  int? _skip;
  int? get skip => _skip ?? 10;
  void setSkip({required int? value}) {
    _skip = value;
  }

  ///
  /// TODO:
  ///
  String? _queryString;
  String? get queryString => _queryString ?? '';
  void setQueryString({required String? value}) {
    _queryString = value;
  }

  ///
  /// TODO:
  ///
  int? _countAllLoaded;
  int? get countAllLoaded => _countAllLoaded ?? 10;
  void setCountAllLoaded({required int? value}) {
    _countAllLoaded = value;
  }

  ///
  /// TODO:
  ///
  void onReset() {
    setSkip(value: 0);
    setCountAllLoaded(value: 0);
    setQueryString(value: '');
  }

  ///
  /// TODO: Constructor
  ///
  UrlParameter({required int? limit, required int? skip, required String? queryString}) {
    setLimit(value: limit);
    setSkip(value: skip);
    setQueryString(value: queryString);
  }
}
