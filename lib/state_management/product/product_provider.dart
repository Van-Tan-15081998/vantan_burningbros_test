import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_demo/models/product/product_model.dart';
import 'package:product_demo/services/api/abstracts/url_parameter.dart';
import 'package:product_demo/services/app_services.dart';
import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/mixins/provider_mixin.dart';

class ProductProvider with ChangeNotifier, ProviderMixin {
  ///
  /// TODO: Constructor
  ///
  ProductProvider() {
    setUrlParameter(value: UrlParameter(limit: 20, skip: 0, queryString: ''));

    AppServices().apiService?.productApi?.setUrlParameter(value: urlParameter);
  }

  ///
  /// TODO:
  ///
  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ///
  /// TODO:
  ///
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///
  /// TODO:
  ///
  Timer? _debounce;

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
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  void setErrorMessage({required String? value}) {
    _errorMessage = value;
  }

  @override
  void onAttach({required AppProviders? attachValue}) {
    setFavoriteProvider(value: attachValue?.favoriteProvider);
    setNetworkProvider(value: attachValue?.networkProvider);
    setNotificationProvider(value: attachValue?.notificationProvider);
  }

  ///
  /// TODO:
  ///
  void onReset() {
    _urlParameter?.setSkip(value: 0);
    _urlParameter?.setCountAllLoaded(value: 0);
    _products.clear();
  }

  ///
  /// TODO:
  ///
  bool _onCheckInternetConnection() {
    if (networkProvider?.isConnected == true) {
      setErrorMessage(value: '');
      notificationProvider?.onClear();

      return true;
    }

    setErrorMessage(value: 'No internet connection. Please check your network and try again.');
    notificationProvider?.onShow(errorMessage ?? 'Error', backgroundColor: Colors.red);

    return false;
  }

  ///
  /// TODO:
  ///
  Future<void> onFetchPagination({bool loadMore = false}) async {
    try {
      ///
      /// TODO: Check Wi-Fi/Internet
      ///
      if (_onCheckInternetConnection() == false) {
        return;
      }

      if (_isLoading) return;
      _isLoading = true;
      notifyListeners();

      if (!loadMore) {
        _urlParameter?.setSkip(value: 0);
        _urlParameter?.setCountAllLoaded(value: 0);
        _products.clear();
      }

      final dynamic response = _urlParameter?.queryString?.isEmpty == true
          ? await AppServices().apiService?.productApi?.onFetchListItem(_urlParameter?.skip ?? 0, _urlParameter?.limit ?? 20)
          : await AppServices().apiService?.productApi?.onSearchListItem(_urlParameter?.skip ?? 0, _urlParameter?.limit ?? 20, _urlParameter?.queryString ?? '');

      if (_products.isNotEmpty == true && response?.isEmpty == true) {
        notificationProvider?.onShow("No more results", backgroundColor: Colors.grey);
      }

      List<ProductModel> loadedProducts = response?.map<ProductModel>((p) => ProductModel.fromJson(p)).toList();
      int countLoadedProducts = loadedProducts.length;

      _products.addAll(response?.map<ProductModel>((p) => ProductModel.fromJson(p)).toList());

      if (countLoadedProducts < (_urlParameter?.limit ?? 20)) {
        _urlParameter?.setSkip(value: (_urlParameter?.skip ?? 0) + countLoadedProducts);
      } else {
        _urlParameter?.setSkip(value: (_urlParameter?.skip ?? 0) + (_urlParameter?.limit ?? 20));
      }

      _urlParameter?.setCountAllLoaded(value: _products.length);

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      setErrorMessage(value: 'Error');
      notificationProvider?.onShow("Failed to load products", backgroundColor: Colors.red);
    }
  }

  ///
  /// TODO:
  ///
  void onSearch({required String query}) {
    /// If debounce is active => cancel
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {

      _urlParameter?.setSkip(value: 0);
      _urlParameter?.setCountAllLoaded(value: 0);
      _products.clear();

      _urlParameter?.setQueryString(value: query);

      await onFetchPagination(loadMore: true);
    });
  }
}
