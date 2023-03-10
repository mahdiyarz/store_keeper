import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/import_presentation.dart';
import 'package:store_keeper/presentation/incoming_goods_management/adding_good_management.dart';
import 'package:store_keeper/widgets/custom_back_button.dart';

import '../../widgets/screens_style.dart';
import '../resources/import_resources.dart';

class TabIncomingGoodsManagementScreen extends StatefulWidget {
  final String title;
  final int boxNumber;
  final DateTime dateTime;
  // final List<GoodsModel> goodsList;
  // final List<BrandsModel> brandsList;
  final int incomingGoodId;
  const TabIncomingGoodsManagementScreen({
    required this.title,
    required this.boxNumber,
    required this.dateTime,
    // required this.goodsList,
    // required this.brandsList,
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

    return ScreensStyle(
      title: widget.title,
      description:
          'ورود ${widget.boxNumber.toString().withPersianNumbers()} کارتن در تاریخ ${widget.dateTime.toPersian()}',
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (state is DisplayAppState) {
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
                  brandsList: state.brandsList,
                  goodsList: state.goodsList,
                ),
                'title': 'ثبت کالاهای ورودی',
                'icon': Icons.add_business_rounded,
              },
            ];
            return Column(
              children: [
                customBottomNavigationBar(width, tabPages),
                const SizedBox(
                  height: 15,
                ),
                tabPages[_selectedIndex]['pageRoute'] as Widget,
              ],
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      actionIcon: const CustomBackButton(pageRoute: Routes.incomingListsRoute),
      bodyButton: const SizedBox(),
    );
  }

  Container customBottomNavigationBar(
      double width, List<Map<String, dynamic>> tabPages) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * .05),
      height: width * .155,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: ColorManager.secondary,
        boxShadow: [
          BoxShadow(
              color: ColorManager.shadow.withOpacity(.5),
              blurRadius: 30,
              offset: const Offset(0, 10)),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 2.8,
          mainAxisExtent: width * .156,
        ),
        itemCount: 2,
        padding: const EdgeInsets.all(0),
        shrinkWrap: false,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              HapticFeedback.lightImpact();
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Center(
            child: Stack(
              children: [
                SizedBox(
                  width: width * .45,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == _selectedIndex ? width * .156 : 0,
                      width: index == _selectedIndex ? width * .46 : 0,
                      decoration: BoxDecoration(
                        color: index == _selectedIndex
                            ? ColorManager.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(13),
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
                                : ColorManager.onSecondary.withOpacity(.6),
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
    );
  }
}
