import 'package:flutter/material.dart';
import 'package:product_demo/screens/product/product_list_screen.dart';
import 'package:product_demo/screens/system/connectivity_widget.dart';
import 'package:product_demo/services/app_services.dart';
import 'package:product_demo/state_management/app_providers.dart';
import 'package:product_demo/state_management/product/favorite_provider.dart';
import 'package:product_demo/state_management/product/product_provider.dart';
import 'package:provider/provider.dart';

import 'state_management/system/network_provider.dart';
import 'state_management/system/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppServices().onInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Product Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: ProductListScreen(),
        home: Scaffold(body: ConnectivityWidget(child: ProductListScreen())),
        builder: (context, child) {
          final productProvider = Provider.of<ProductProvider>(context, listen: false);
          final favoriteProductProvider = Provider.of<FavoriteProvider>(context, listen: false);
          final networkProvider = Provider.of<NetworkProvider>(context, listen: false);
          final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

          AppProviders().onInit(
            productProvider: productProvider, //
            favoriteProvider: favoriteProductProvider, //
            networkProvider: networkProvider, //
            notificationProvider: notificationProvider,
          );

          return Consumer<NotificationProvider>(
            builder: (context, notifier, childWidget) {
              if (notifier.notification != null) {
                final note = notifier.notification!;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.hideCurrentSnackBar();
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(note.message, style: TextStyle(fontSize: 16, color: Colors.black87)),
                      backgroundColor: note.backgroundColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  notifier.clear();
                });
              }
              return childWidget!;
            },
            child: child,
          );
        },
      ),
    );
  }
}
