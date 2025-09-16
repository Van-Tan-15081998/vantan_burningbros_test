import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/mixins/app_providers.dart';

class NetworkProvider with ChangeNotifier, ProviderMixin {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  List<ConnectivityResult> _status = [ConnectivityResult.none];
  List<ConnectivityResult> get status => _status;

  bool get isConnected => !_status.contains(ConnectivityResult.none); // true nếu có wifi/mobile

  NetworkProvider() {
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  @override
  void onAttach({required AppProviders? attachValue}) {
    setNotificationProvider(value: attachValue?.notificationProvider);
  }

  Future<void> init() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);
  }

  Future<void> onReCheckStatus() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);
  }

  void _updateStatus(List<ConnectivityResult> result) {
    _status = result;

    if (isConnected == true) {
      notificationProvider?.show("Online", backgroundColor: Colors.greenAccent);
    } else {
      notificationProvider?.show("Offline.", backgroundColor: Colors.orangeAccent);
    }

    notifyListeners();
  }

  // Future<void> Function() onCallback;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
