import 'package:product_demo/services/api/abstracts/url_parameter.dart';

abstract class ApiAbstract {
  ///
  /// TODO: Constructor
  ///
  ApiAbstract({required String? baseUrl, required UrlParameter? urlParameter}) {
    setBaseUrl(value: baseUrl);

    setUrlParameter(value: urlParameter);

    onInit();
  }

  ///
  /// TODO:
  ///
  String? _baseUrl;
  String? get baseUrl => _baseUrl;
  void setBaseUrl({required String? value}) {
    _baseUrl = value;
  }

  ///
  /// TODO:
  ///
  String _defaultUrl = '';
  String get defaultUrl => _defaultUrl;
  void setDefaultUrl({required String value}) {
    _defaultUrl = value;
  }

  ///
  /// TODO:
  ///
  String? _fetchListItemUrl;
  String? get fetchListItemUrl => _fetchListItemUrl;
  void setFetchListItemUrl({required String? value}) {
    _fetchListItemUrl = value;
  }

  ///
  /// TODO:
  ///
  String? _searchListItemUrl;
  String? get searchListItemUrl => _searchListItemUrl;
  void setSearchListItemUrl({required String? value}) {
    _searchListItemUrl = value;
  }

  ///
  /// TODO:
  ///
  UrlParameter? _urlParameter;
  UrlParameter? get urlParameter => _urlParameter;
  void setUrlParameter({required UrlParameter? value}) {
    _urlParameter = value;
  }

  ///
  /// TODO:
  ///
  void onInit();

  ///
  /// TODO:
  ///
  void onUpdateFetchListItemUrl() {
    setFetchListItemUrl(value: '$baseUrl?skip=${urlParameter?.skip}&limit=${urlParameter?.limit}');
  }

  ///
  /// TODO:
  ///
  void onUpdateSearchListItemUrl() {
    setSearchListItemUrl(value: '$baseUrl/search?q=${urlParameter?.queryString}');
  }

  ///
  /// TODO:
  ///
  Future<List<dynamic>> onFetchListItem(int skip, int limit);

  ///
  /// TODO:
  ///
  Future<List<dynamic>> onSearchListItem(int skip, int limit, String query);
}
