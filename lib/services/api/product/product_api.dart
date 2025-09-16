import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_demo/services/api/abstracts/api_abstract.dart';

class ProductApi extends ApiAbstract {

  ///
  /// TODO: Constructor
  ///
  ProductApi({required super.baseUrl, required super.urlParameter});

  @override
  void onInit() {
    setBaseUrl(value: '$baseUrl/products');

    setDefaultUrl(value: 'https://dummyjson.com/products?limit=10&skip=10');

    onUpdateFetchListItemUrl();
    onUpdateSearchListItemUrl();
  }

  ///
  /// TODO:
  ///
  @override
  Future<List> onFetchListItem(int skip, int limit) async {
    urlParameter?.setSkip(value: skip);
    urlParameter?.setLimit(value: limit);

    onUpdateFetchListItemUrl();

    final response = await http.get(Uri.parse(fetchListItemUrl ?? defaultUrl));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['total'] > (urlParameter?.countAllLoaded ?? 0)) {
        return jsonDecode(response.body)['products'];
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load products");
    }
  }

  ///
  /// TODO:
  ///
  @override
  Future<List> onSearchListItem(int skip, int limit, String query) async {
    urlParameter?.setSkip(value: skip);
    urlParameter?.setLimit(value: limit);
    urlParameter?.setQueryString(value: query);

    onUpdateSearchListItemUrl();

    final response = await http.get(Uri.parse(searchListItemUrl ?? defaultUrl));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['total'] > (urlParameter?.countAllLoaded ?? 0)) {
        return jsonDecode(response.body)['products'];
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to search products");
    }
  }
}
