import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';
import '../home/home.dart';
import '../arrival_goods/arrival_goods.dart';
import '../brands/brands.dart';

class Routes {
  static const String arrivalGoodsRoute = '/arrival-goods';
  static const String homeRoute = '/home';
  static const String brandsRoute = '/brands';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.arrivalGoodsRoute:
        return MaterialPageRoute(builder: (_) => const ArrivalGoods());
      case Routes.brandsRoute:
        return MaterialPageRoute(builder: (_) => const Brands());
      // case Routes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => const Home());
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => const RegisterView());
      // case Routes.forgotPasswordRoute:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case Routes.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
