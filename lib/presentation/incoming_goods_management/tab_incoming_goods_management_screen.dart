import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/models/goods_model.dart';
import 'package:store_keeper/presentation/import_presentation.dart';
import 'package:store_keeper/presentation/incoming_goods_management/adding_good_management.dart';
import 'package:store_keeper/widgets/custom_back_button.dart';

import '../../widgets/screens_style.dart';
import '../resources/import_resources.dart';

class TabIncomingGoodsManagementScreen extends StatefulWidget {
  final String title;
  final int boxNumber;
  final DateTime dateTime;
  final List<GoodsModel> goodsList;
  final List<BrandsModel> brandsList;
  final int incomingGoodId;
  const TabIncomingGoodsManagementScreen({
    required this.title,
    required this.boxNumber,
    required this.dateTime,
    required this.goodsList,
    required this.brandsList,
    required this.incomingGoodId,
    Key? key,
  }) : super(key: key);

  @override
  State<TabIncomingGoodsManagementScreen> createState() =>
      _TabIncomingGoodsManagementScreenState();
}

class _TabIncomingGoodsManagementScreenState
    extends State<TabIncomingGoodsManagementScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final List<Map<String, dynamic>> tabPages = [
      {
        'pageRoute': IncomingGoodsManagementScreen(
          incomingListId: widget.incomingGoodId,
        ),
        'title': 'مدیریت کالاهای ورودی',
        'icon': Icons.manage_history_rounded,
      },
      {
        'pageRoute': AddingGoodManagement(
          incomingGoodId: widget.incomingGoodId,
          brandsList: widget.brandsList,
          goodsList: widget.goodsList,
        ),
        'title': 'ثبت کالاهای ورودی',
        'icon': Icons.add_business_rounded,
      },
    ];

    return ScreensStyle(
      title: widget.title,
      description:
          'ورود ${widget.boxNumber.toString().withPersianNumbers()} کارتن در تاریخ ${widget.dateTime.toPersian()}',
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .04),
            height: width * .155,
            decoration: BoxDecoration(
              color: ColorManager.secondary,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10)),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 2,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    HapticFeedback.lightImpact();
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .015),
                  child: Stack(
                    children: [
                      Positioned(
                        top: width * .01,
                        child: SizedBox(
                          width: width * .43,
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height:
                                  index == _selectedIndex ? width * .135 : 0,
                              width: index == _selectedIndex ? width * .45 : 0,
                              decoration: BoxDecoration(
                                color: index == _selectedIndex
                                    ? ColorManager.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: width * .01,
                        child: Container(
                          width: width * .45,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                tabPages[index]['icon'],
                                size: width * .076,
                                color: index == _selectedIndex
                                    ? ColorManager.onPrimary
                                    : ColorManager.onSecondary.withOpacity(.6),
                              ),
                              Text(
                                tabPages[index]['title'],
                                style: TextStyle(
                                  color: index == _selectedIndex
                                      ? ColorManager.onPrimary
                                      : ColorManager.onSecondary
                                          .withOpacity(.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          tabPages[_selectedIndex]['pageRoute'] as Widget,
        ],
      ),
      actionIcon: const CustomBackButton(pageRoute: Routes.incomingListsRoute),
      bodyButton: const SizedBox(),
    );
  }
}
