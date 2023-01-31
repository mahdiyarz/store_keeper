import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/brands_bloc/brands_repository.dart';

import '../presentation/resources/import_resources.dart';
import '../bloc/bloc_exports.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BrandsBloc>(
          create: (_) => BrandsBloc(repository: BrandsRepositoryImplement()),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ArrivalGoodsProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => BrandsProvider(),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeRoute,
      ),
    );
  }
}
