import 'package:ecomerce/features/auth/presentation/screens/account_information.dart';
import 'package:ecomerce/features/cart/presentation/screens/my_all_carts.dart';
import 'package:ecomerce/features/home/data/repositories/models/products.dart';
import 'package:ecomerce/features/home/presentation/screens/all_products_screen.dart';
import 'package:ecomerce/features/home/presentation/screens/home_screen.dart';
import 'package:ecomerce/features/home/presentation/screens/services_screen.dart';
import 'package:ecomerce/features/home/presentation/screens/single_product_screen.dart';
import 'package:ecomerce/features/product/presentation/screens/my_single_product_screen.dart';
import 'package:ecomerce/features/product/presentation/screens/my_products_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String onboarding = '/onboarding';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String productsList = '/productsList';
  static const String singleProduct = '/singleProduct';
  static const String services = '/services';
  static const String mySingleProduct = '/mySingleProduct';
  static const String myProducts = '/myProducts';
  static const String accountInformation = '/accountInformation';
  static const String myAllCartScreens = '/myAllCartScreens';
}

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
     
      // case Routes.initialRoute:
      //   return MaterialPageRoute(builder: (context) {
      //     return StorageService.getUserToken().isNotEmpty
      //         ? HomeScreen()
      //         : const SplashScreen();
      //   });
      case Routes.splash:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
      case Routes.login:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
      case Routes.productsList:
        return MaterialPageRoute(builder: (context) {
          var screenName = routeSettings.arguments as String;
          return AllProductsScreen(nameOfScreen: screenName);
        });
      case Routes.singleProduct:
        return MaterialPageRoute(builder: (context) {
          var productId = routeSettings.arguments as int;
          return SingleProductScreen(productId: productId);
        });
      case Routes.services:
        return MaterialPageRoute(builder: (context) {
          return ServicesScreen();
        });
      case Routes.mySingleProduct:
        return MaterialPageRoute(builder: (context) {
          var args = routeSettings.arguments as Map<String, dynamic> ;
          return MySingleProduct(args: args);
        });
      case Routes.myProducts:
        return MaterialPageRoute(builder: (context) {
          return MyProducts();
        });
         case Routes.accountInformation:
        return MaterialPageRoute(builder: (context) {
          var productId = routeSettings.arguments as int;
          return AccountInformation(userId: productId);
        });
         case Routes.myAllCartScreens:
        return MaterialPageRoute(builder: (context) {
          return MyAllCarts();
        });
    }
  }
}
