import 'package:flutter/material.dart';
import 'package:product_demo/services/app_services.dart';
import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/mixins/app_providers.dart';

class FavoriteProvider with ChangeNotifier, ProviderMixin {
  FavoriteProvider();

  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  @override
  void onAttach({required AppProviders? attachValue}) {
    setNotificationProvider(value: attachValue?.notificationProvider);
  }

  ///
  /// TODO:
  ///
  Future<void> loadFavorites() async {
    final ids = await AppServices().databaseService?.favoriteProductDB?.getAllFavorites() ?? [];
    _favoriteIds.clear();
    _favoriteIds.addAll(ids);
    notifyListeners();
  }

  ///
  /// TODO:
  ///
  bool isFavorite(int id) => _favoriteIds.contains(id);

  ///
  /// TODO:
  ///
  Future<void> toggleFavorite(int id) async {
    if (isFavorite(id)) {
      _favoriteIds.remove(id);
      await AppServices().databaseService?.favoriteProductDB?.removeFavorite(id);

      notificationProvider?.show('Removed from favorites', backgroundColor: Colors.greenAccent);
    } else {
      _favoriteIds.add(id);
      await AppServices().databaseService?.favoriteProductDB?.addFavorite(id);

      notificationProvider?.show('Added to favorites', backgroundColor: Colors.greenAccent);
    }
    notifyListeners();
  }

  ///
  /// TODO:
  ///
  Future<void> clearAll() async {
    _favoriteIds.clear();
    await AppServices().databaseService?.favoriteProductDB?.clearFavorites();
    notifyListeners();
  }
}
