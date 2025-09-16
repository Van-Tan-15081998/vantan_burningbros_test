import 'package:flutter/material.dart';
import 'package:product_demo/state_management/system/network_provider.dart';
import 'package:provider/provider.dart';

class ConnectivityWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityWidget({super.key, required this.child});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  NetworkProvider? _networkProvider;

  bool _isConnecting = true;

  @override
  void initState() {
    super.initState();

    _networkProvider = Provider.of<NetworkProvider>(context, listen: false);

    ///
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _networkProvider?.onInit();

      if (_networkProvider?.isConnected == true) {
        setState(() {
          _isConnecting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, network, child) {
        if (_isConnecting == true) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Connecting...")]),
          );
        }

        if (network.isConnected == true) {
          return widget.child;
        }

        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 64, color: Colors.grey),
              SizedBox(height: 12),
              Text("No internet connection"),
            ],
          ),
        );
      },
    );
  }
}
