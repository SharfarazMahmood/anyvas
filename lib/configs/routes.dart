import 'package:flutter/material.dart';
//////// import of other screens, widgets ////////
import '../screens/signup/signup_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/product/product_details.dart';
import '../screens/products_overview_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (context) => LoginScreen(),
    SignupScreen.routeName: (context) => SignupScreen(),
    ProductsOverviewScreen.routeName: (context) => ProductsOverviewScreen(),
    ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
  };
}
