import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/mixins/provider_mixin.dart';

class NetworkProvider with ChangeNotifier, ProviderMixin {

  ///
  /// TODO: Constructor
  ///
  NetworkProvider() {
    _subscription = _connectivity.onConnectivityChanged.listen(_onUpdateStatus);
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  List<ConnectivityResult> _status = [ConnectivityResult.none];
  List<ConnectivityResult> get status => _status;

  bool get isConnected => !_status.contains(ConnectivityResult.none);

  @override
  void onAttach({required AppProviders? attachValue}) {
    setNotificationProvider(value: attachValue?.notificationProvider);
  }

  ///
  /// TODO:
  ///
  Future<void> onInit() async {
    final result = await _connectivity.checkConnectivity();
    _onUpdateStatus(result);
  }

  ///
  /// TODO:
  ///
  Future<void> onReCheckStatus() async {
    final result = await _connectivity.checkConnectivity();
    _onUpdateStatus(result);
  }

  ///
  /// TODO:
  ///
  void _onUpdateStatus(List<ConnectivityResult> result) {
    _status = result;

    if (isConnected == true) {
      notificationProvider?.onShow("Online", backgroundColor: Colors.greenAccent);
    } else {
      notificationProvider?.onShow("Offline.", backgroundColor: Colors.orangeAccent);
    }

    notifyListeners();
  }

  ///
  /// TODO:
  ///
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
