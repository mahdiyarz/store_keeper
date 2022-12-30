import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/import_providers.dart';

import '../presentation/resources/routes_manager.dart';

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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeRoute,
      ),
    );
  }
}
