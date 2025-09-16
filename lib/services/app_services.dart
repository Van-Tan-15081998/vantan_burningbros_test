import 'package:product_demo/services/api/api_service.dart';
import 'package:product_demo/services/database/database_service.dart';

///
/// TODO:
///
class AppServices {
  static final AppServices _instance = AppServices._internal();
  factory AppServices() => _instance;

  AppServices._internal();

  ///
  /// TODO:
  ///
  onInit() {
    setApiService(value: ApiService());
    setDatabaseService(value: DatabaseService());
  }

  ///
  /// TODO:
  ///
  ApiService? _apiService;
  ApiService? get apiService => _apiService;
  void setApiService({required ApiService? value}) {
    _apiService = value;
  }

  ///
  /// TODO:
  ///
  DatabaseService? _databaseService;
  DatabaseService? get databaseService => _databaseService;
  void setDatabaseService({required DatabaseService? value}) {
    _databaseService = value;
  }
}
