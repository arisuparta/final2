import 'package:aa/lib%20-%20login%20register/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';

import 'lib - login register/providers/products.dart';

// import './pages/home_page.dart';
import 'lib - login register/pages/auth_page.dart';
import 'lib - login register/pages/add_product_page.dart';
import 'lib - login register/pages/edit_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (ctx) => Auth(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => Products(),
      ),
    ],
    builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          AddProductPage.route: (ctx) => AddProductPage(),
          EditProductPage.route: (ctx) => EditProductPage(),
        },
      ),
    );
  }
}
