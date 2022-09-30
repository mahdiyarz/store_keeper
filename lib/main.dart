import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/brands_provider.dart';
import '../providers/arrival_goods_provider.dart';

import '../screens/arrival_goods.dart';
import '../screens/home.dart';
import '../screens/add_arrival_goods.dart';
import '../screens/brands.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArrivalGoodsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BrandsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'vazir',
        ),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: Home(),
        ),
        routes: {
          '/arrival-goods': (context) => const ArrivalGoods(),
          '/add-arrival-goods': (context) => AddArrivalGoods(),
          '/brands': (context) => const Brands(),
        },
      ),
    );
  }
}
