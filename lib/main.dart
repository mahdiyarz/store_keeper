import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/arrival_goods_provider.dart';

import '../screens/arrival_goods.dart';
import '../screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ArrivalGoodsProvider>(
            create: (context) => ArrivalGoodsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'vazir',
        ),
        home: const Home(),
        routes: {
          '/arrival-goods': (context) => const ArrivalGoods(),
        },
      ),
    );
  }
}
