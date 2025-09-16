import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/product/favorite_provider.dart';
import 'package:product_demo/state_management/product/product_provider.dart';
import 'package:product_demo/state_management/system/network_provider.dart';
import 'package:product_demo/state_management/system/notification_provider.dart';

mixin ProviderMixin {
  ///
  /// TODO:
  ///
  void onAttach({required AppProviders? attachValue}) {
    return;
  }

  ///
  /// TODO:
  ///
  ProductProvider? _productProvider;
  ProductProvider? get productProvider => _productProvider;
  void setProductProvider({required ProductProvider? value}) {
    _productProvider = value;
  }

  ///
  /// TODO:
  ///
  FavoriteProvider? _favoriteProvider;
  FavoriteProvider? get favoriteProvider => _favoriteProvider;
  void setFavoriteProvider({required FavoriteProvider? value}) {
    _favoriteProvider = value;
  }

  ///
  /// TODO:
  ///
  NetworkProvider? _networkProvider;
  NetworkProvider? get networkProvider => _networkProvider;
  void setNetworkProvider({required NetworkProvider? value}) {
    _networkProvider = value;
  }

  ///
  /// TODO:
  ///
  NotificationProvider? _notificationProvider;
  NotificationProvider? get notificationProvider => _notificationProvider;
  void setNotificationProvider({required NotificationProvider? value}) {
    _notificationProvider = value;
  }
}
