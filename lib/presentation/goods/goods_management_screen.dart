import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/widgets/goods_list_view.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/show_modal_bottom_button.dart';
import 'create_or_update_good_screen.dart';

class GoodsManagementScreen extends StatelessWidget {
  const GoodsManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: 'مدیریت کالاها',
      description: 'ثبت، اصلاح و یا حذف کالا',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: const ShowModalBottomButton(
        buttonTitle: 'ایجاد کالای جدید',
        buttonIcon: Icons.playlist_add_circle_rounded,
        showModalChildWidget: CreateOrUpdateGoodScreen(
          oldGood: null,
          brandsList: null,
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(
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
    );
  }
}
