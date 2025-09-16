import 'package:product_demo/services/api/product/product_api.dart';

class ApiService {
  final String _baseUrl = "https://dummyjson.com";
  String get baseUrl => _baseUrl;

  ///
  /// TODO:
  ///
  ProductApi? _productApi;
  ProductApi? get productApi => _productApi;
  void setProductApi({required ProductApi? value}) {
    _productApi = value;
  }

  ///
  /// TODO: Constructor
  ///
  ApiService() {
    setProductApi(value: ProductApi(baseUrl: baseUrl, urlParameter: null));
  }
}
