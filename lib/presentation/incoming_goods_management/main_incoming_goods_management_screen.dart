import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/models/import_models.dart';
import 'package:store_keeper/presentation/incoming_goods_management/tab_incoming_goods_management_screen.dart';
import 'package:store_keeper/widgets/custom_back_button.dart';

import '../../widgets/screens_style.dart';
import '../resources/import_resources.dart';

class MainIncomingGoodsManagementScreen extends StatefulWidget {
  final IncomingsModel incomingInformation;
  final String title;
  const MainIncomingGoodsManagementScreen({
    required this.incomingInformation,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<MainIncomingGoodsManagementScreen> createState() =>
      _MainIncomingGoodsManagementScreenState();
}

class _MainIncomingGoodsManagementScreenState
    extends State<MainIncomingGoodsManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreensStyle(
      title: widget.title,
      description:
          'ورود ${widget.incomingInformation.boxes.toString().withPersianNumbers()} کارتن در تاریخ ${widget.incomingInformation.incomingDate.toPersian()}',
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (state is DisplayAppState) {
            return TabIncomingGoodsManagementScreen(
              incomingGoodId: widget.incomingInformation.incomingId!,
              goodsList: state.goodsList,
              brandsList: state.brandsList,
              warehousesList: state.warehousesList,
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
}
