import 'package:flutter/material.dart';
import 'package:product_demo/state_management/mixins/provider_mixin.dart';

class NotificationProvider with ChangeNotifier, ProviderMixin {
  AppNotification? _notification;
  AppNotification? get notification => _notification;

  ///
  /// TODO:
  ///
  void onShow(String message, {Color backgroundColor = Colors.black87}) {
    _notification = AppNotification(message, backgroundColor: backgroundColor);
    notifyListeners();
  }

  ///
  /// TODO:
  ///
  void onClear() {
    _notification = null;
    notifyListeners();
  }
}

class AppNotification {
  final String message;
  final Color backgroundColor;

  AppNotification(this.message, {this.backgroundColor = Colors.black87});
}
