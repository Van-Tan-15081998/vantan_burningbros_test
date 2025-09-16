import 'package:product_demo/state_management/mixins/provider_mixin.dart';
import 'package:product_demo/state_management/product/favorite_provider.dart';
import 'package:product_demo/state_management/product/product_provider.dart';
import 'package:product_demo/state_management/system/network_provider.dart';
import 'package:product_demo/state_management/system/notification_provider.dart';

///
/// TODO:
///
class AppProviders with ProviderMixin {
  static final AppProviders _instance = AppProviders._internal();

  factory AppProviders() => _instance;

  AppProviders._internal();

  ///
  /// TODO:
  ///
  void onInit({
    required ProductProvider? productProvider,
    required FavoriteProvider? favoriteProvider,
    required NetworkProvider? networkProvider,
    required NotificationProvider? notificationProvider,
  }) {
    ///
    setProductProvider(value: productProvider);
    setFavoriteProvider(value: favoriteProvider);
    setNetworkProvider(value: networkProvider);
    setNotificationProvider(value: notificationProvider);

    ///
    productProvider?.onAttach(attachValue: this);
    favoriteProvider?.onAttach(attachValue: this);
    networkProvider?.onAttach(attachValue: this);
    notificationProvider?.onAttach(attachValue: this);
  }
}
