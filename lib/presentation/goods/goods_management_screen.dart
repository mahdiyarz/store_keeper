import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/widgets/goods_list_view.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/show_modal_bottom_button.dart';
import 'create_or_update_good_screen.dart';

class GoodsManagementScreen extends StatefulWidget {
  const GoodsManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GoodsManagementScreen> createState() => _GoodsManagementScreenState();
}

class _GoodsManagementScreenState extends State<GoodsManagementScreen> {
  bool isInfoButtonToggle = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: 'مدیریت کالاها',
      description: 'اینجا ثبت کن، اصلاح و یا حذف کن',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: Row(
        children: [
          const Expanded(
            child: ShowModalBottomButton(
              buttonTitle: 'ثبت یک کالای جدید',
              buttonIcon: Icons.app_registration_rounded,
              showModalChildWidget: CreateOrUpdateGoodScreen(
                oldGood: null,
                brandsList: null,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: ColorManager.error.withOpacity(.7),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isInfoButtonToggle = !isInfoButtonToggle;
                  });
                },
                icon: Icon(
                  Icons.question_mark_rounded,
                  color: ColorManager.onError,
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isInfoButtonToggle,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(
                bottom: 5,
                left: 23,
                right: 23,
              ),
              decoration: BoxDecoration(
                color: ColorManager.error.withOpacity(.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: ColorManager.onError,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          'ایجاد کالا: پایین صفحه روی دکمه ثبت یک کالای جدید کلیک کنید.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorManager.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: ColorManager.onError,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          'ویرایش/حذف: روی هر کدوم از کالاها که میخواین عملیات ویژه انجام بدید، دوبار روش کلیک کنید.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorManager.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              if (appState is AppStateInitial) {
                context.read<AppBloc>().add(const FetchEvent());
              }
              if (appState is DisplayAppState) {
                return appState.goodsList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GoodsListView(
                          width: screenWidth,
                          brandsList: appState.brandsList,
                          goodsList: appState.goodsList,
                        ),
                      )
                    : Column(
                        children: [
                          Image.asset(ImageAssets.goodsScreen),
                          const Text('چرا هنوز کالایی نیست اینجا؟'),
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
