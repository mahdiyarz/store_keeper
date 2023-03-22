import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import 'local_widgets/goods_stock_summary_list_view.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  bool isInfoButtonToggle = false;
  @override
  Widget build(BuildContext context) {
    return ScreensStyle(
      title: 'موجودی کالاها',
      description: 'اینجا تمام موجودی هارو چک کن',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: const SizedBox(),
      // Row(
      //   children: [
      //     const Expanded(
      //       child: ShowModalBottomButton(
      //         buttonTitle: 'ثبت یک کالای جدید',
      //         buttonIcon: Icons.app_registration_rounded,
      //         showModalChildWidget: CreateOrUpdateGoodScreen(
      //           oldGood: null,
      //           brandsList: null,
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     CircleAvatar(
      //       backgroundColor: ColorManager.error.withOpacity(.7),
      //       child: IconButton(
      //           onPressed: () {
      //             setState(() {
      //               isInfoButtonToggle = !isInfoButtonToggle;
      //             });
      //           },
      //           icon: Icon(
      //             Icons.question_mark_rounded,
      //             color: ColorManager.onError,
      //           )),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          // Visibility(
          //   visible: isInfoButtonToggle,
          //   child: Container(
          //     width: screenWidth,
          //     padding: const EdgeInsets.symmetric(
          //       vertical: 8,
          //       horizontal: 10,
          //     ),
          //     margin: const EdgeInsets.only(
          //       bottom: 5,
          //       left: 23,
          //       right: 23,
          //     ),
          //     decoration: BoxDecoration(
          //       color: ColorManager.error.withOpacity(.7),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Column(
          //       children: [
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Icon(
          //               Icons.attachment,
          //               color: ColorManager.onError,
          //             ),
          //             const SizedBox(
          //               width: 3,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 'ایجاد کالا: پایین صفحه روی دکمه ثبت یک کالای جدید کلیک کنید.',
          //                 textAlign: TextAlign.justify,
          //                 style: TextStyle(
          //                   color: ColorManager.onError,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Icon(
          //               Icons.attachment,
          //               color: ColorManager.onError,
          //             ),
          //             const SizedBox(
          //               width: 3,
          //             ),
          //             Expanded(
          //               child: Text(
          //                 'ویرایش/حذف: روی هر کدوم از کالاها که میخواین عملیات ویژه انجام بدید، دوبار روش کلیک کنید.',
          //                 textAlign: TextAlign.justify,
          //                 style: TextStyle(
          //                   color: ColorManager.onError,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              if (appState is AppStateInitial) {
                context.read<AppBloc>().add(const FetchEvent());
              }
              if (appState is DisplayAppState) {
                return appState.goodsList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GoodsStockSummaryListView(
                          stockList: appState.stocksList,
                          brandsList: appState.brandsList,
                          goodsList: appState.goodsList,
                          warehousesList: appState.warehousesList,
                        ),
                      )
                    : Column(
                        children: [
                          Image.asset(ImageAssets.goodsScreen),
                          const Text('انبار خالیه خالیه...'),
                        ],
                      );
              }
              return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}
