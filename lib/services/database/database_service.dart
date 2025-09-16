import 'package:product_demo/services/database/product/favorite_product_db.dart';

class DatabaseService {
  ///
  /// TODO: Constructor
  ///
  DatabaseService() {
    setFavoriteProductDB(value: FavoriteProductDB());
  }

  ///
  /// TODO:
  ///
  FavoriteProductDB? _favoriteProductDB;
  FavoriteProductDB? get favoriteProductDB => _favoriteProductDB;
  void setFavoriteProductDB({required FavoriteProductDB? value}) {
    _favoriteProductDB ??= value;
  }
}
