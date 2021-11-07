import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//////// import of config files ////////
import '../configs/providers_list.dart';
import '../configs/routes.dart';
import '../configs/theme.dart';
//////// import of other screens, widgets ////////
import '../screens/splash_screen.dart';
import '../screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: "Anyvas",
        home: Splash(),
        // home: AnimatedSplashScreen(
        //   duration: 2000,
        //   splash: Splash(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   nextScreen: ProductsOverviewScreen(),
        //   backgroundColor: const Color(0xff001a41),
        // ),
        routes: Routes.routes,
      ),
    );
  }
}
