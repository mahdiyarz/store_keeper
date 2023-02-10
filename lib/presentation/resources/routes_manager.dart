import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/resources/assets_manager.dart';

import '../resources/strings_manager.dart';
import '../import_presentation.dart';

class Routes {
  static const String incomingListsRoute = '/incoming-list';
  static const String homeRoute = '/home';
  static const String brandsRoute = '/brands-management';
  static const String incomingGoodsManagementRoute =
      '/incoming-goods-management';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const Home());
      case Routes.incomingListsRoute:
        return MaterialPageRoute(builder: (context) => IncomingListScreen());
      case Routes.brandsRoute:
        return MaterialPageRoute(
            builder: (context) => const BrandsManagementScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageAssets.notFoundPageRoute),
                  const Text(AppStrings.noRouteFound),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.homeRoute);
                      },
                      child: const Text('بازگشت به صفحه اصلی'))
                ],
              ),
            ));
  }
}
