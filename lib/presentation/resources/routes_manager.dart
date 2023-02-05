import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';
import '../import_presentation.dart';

class Routes {
  static const String incomingGoodsListsRoute = '/incoming-goods-list';
  static const String homeRoute = '/home';
  static const String brandsRoute = '/brands-management';
  static const String incomingGoodsManagementRoute =
      '/incoming-goods-management';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.incomingGoodsListsRoute:
        return MaterialPageRoute(
            builder: (_) => const IncomingGoodsListScreen());
      case Routes.brandsRoute:
        return MaterialPageRoute(
            builder: (_) => const BrandsManagementScreen());
      case Routes.incomingGoodsManagementRoute:
        final args = routeSettings.arguments as IncomingGoodsManagementScreen;
        return MaterialPageRoute(
          builder: (_) => IncomingGoodsManagementScreen(
            title: args.title,
            boxNumber: args.boxNumber,
            dateTime: args.dateTime,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Home());
      // unDefinedRoute();
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
