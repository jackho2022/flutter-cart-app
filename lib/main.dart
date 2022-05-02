import 'package:cart_app/model/cart.dart';
import 'package:cart_app/view/cart.dart';
import 'package:cart_app/view/catalog.dart';
import 'package:cart_app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/catalog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Catalog()),
        ChangeNotifierProxyProvider<Catalog, ShoppingCart>(
          create: (context) => ShoppingCart(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/catalog': (context) => const CatalogPage(),
          '/cart': (context) => const ShoppingCartPage(),
        },
      ),
    );
  }
}
