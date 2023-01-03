import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';
import '../import_presentation.dart';

class Routes {
  static const String arrivalGoodsRoute = '/arrival-goods-list';
  static const String homeRoute = '/home';
  static const String brandsRoute = '/brands';
  static const String arrivalGoodsManageRoute = '/arrival-goods-manage';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.arrivalGoodsRoute:
        return MaterialPageRoute(builder: (_) => const ArrivalGoodsList());
      case Routes.brandsRoute:
        return MaterialPageRoute(builder: (_) => const Brands());
      case Routes.arrivalGoodsManageRoute:
        final args = routeSettings.arguments as ArrivalGoodsManagement;
        return MaterialPageRoute(
          builder: (_) => ArrivalGoodsManagement(
            title: args.title,
            boxNumber: args.boxNumber,
            dateTime: args.dateTime,
          ),
        );
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
