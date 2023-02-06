import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/incoming_list_bloc/incoming_list_bloc.dart';

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
          create: (context) => BrandsBloc(),
        ),
        BlocProvider<IncomingListBloc>(
          create: (context) => IncomingListBloc(),
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
