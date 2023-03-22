import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/incoming_goods_management/tab_incoming_goods_management_screen.dart';
import 'package:store_keeper/presentation/resources/assets_manager.dart';
import 'package:store_keeper/presentation/stock/stock_screen.dart';
import 'package:store_keeper/presentation/warehouse/warehouses_management_screen.dart';

import '../goods/goods_management_screen.dart';
import '../persons/persons_management_screen.dart';
import '../resources/strings_manager.dart';
import '../import_presentation.dart';

class Routes {
  static const String incomingListsRoute = '/incoming-list';
  static const String homeRoute = '/home';
  static const String brandsRoute = '/brands-management';
  static const String tabIncomingGoodsRoute = '/tab-incoming-goods';
  static const String goodsRoute = '/goods-management';
  static const String personsRoute = '/persons-management';
  static const String warehouseRoute = '/warehouse-management';
  static const String stockRoute = '/stock';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const Home());
      case Routes.incomingListsRoute:
        return MaterialPageRoute(builder: (context) => const IncomingsScreen());
      case Routes.brandsRoute:
        return MaterialPageRoute(
            builder: (context) => const BrandsManagementScreen());
      case Routes.goodsRoute:
        return MaterialPageRoute(
          builder: (context) => const GoodsManagementScreen(),
        );
      case Routes.personsRoute:
        return MaterialPageRoute(
          builder: (context) => const PersonsManagementScreen(),
        );
      case Routes.warehouseRoute:
        return MaterialPageRoute(
          builder: (context) => const WarehousesManagementScreen(),
        );
      case Routes.stockRoute:
        return MaterialPageRoute(
          builder: (context) => const StockScreen(),
        );
      case Routes.tabIncomingGoodsRoute:
        final args =
            routeSettings.arguments as TabIncomingGoodsManagementScreen;
        return MaterialPageRoute(
          builder: (context) => TabIncomingGoodsManagementScreen(
            title: args.title,
            boxNumber: args.boxNumber,
            dateTime: args.dateTime,
            incomingGoodId: args.incomingGoodId,
          ),
        );

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
