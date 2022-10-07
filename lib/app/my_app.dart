import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/brands_provider.dart';
import '../providers/arrival_goods_provider.dart';

import '../presentation/arrival_goods/arrival_goods.dart';
import '../presentation/home/home.dart';
import '../presentation/brands/brands.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 120, 151, 171),
            onPrimary: const Color.fromARGB(255, 255, 255, 255),
            secondary: const Color.fromARGB(255, 216, 133, 163),
            onSecondary: const Color.fromARGB(255, 255, 255, 255),
            error: const Color.fromARGB(255, 164, 74, 63),
            onError: const Color.fromARGB(255, 255, 255, 255),
            primaryContainer: const Color.fromARGB(255, 253, 206, 185),
          ),
        ),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: Home(),
        ),
        routes: {
          '/arrival-goods': (context) => const ArrivalGoods(),
          '/brands': (context) => const Brands(),
        },
      ),
    );
  }
}
