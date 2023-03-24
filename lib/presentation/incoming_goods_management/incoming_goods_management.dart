import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/incoming_goods_management/local_widgets/transferred_goods_list_view.dart';

import '../../models/import_models.dart';
import '../resources/import_resources.dart';

class IncomingGoodsManagementScreen extends StatefulWidget {
  final int incomingListId;
  const IncomingGoodsManagementScreen({
    required this.incomingListId,
    Key? key,
  }) : super(key: key);

  @override
  State<IncomingGoodsManagementScreen> createState() =>
      _IncomingGoodsManagementScreenState();
}

class _IncomingGoodsManagementScreenState
    extends State<IncomingGoodsManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        if (appState is AppStateInitial) {
          context.read<AppBloc>().add(const FetchEvent());
        }
        if (appState is DisplayAppState) {
          final List<CountedIncomingsModel> transferredGoodsList = appState
              .countedIncomingsList
              .where((element) => element.incomingsId == widget.incomingListId)
              .toList();
          return appState.countedIncomingsList
                  .where(
                      (element) => element.incomingsId == widget.incomingListId)
                  .isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TransferredGoodsListView(
                    transferredGoods: transferredGoodsList,
                    brandsList: appState.brandsList,
                    goodsList: appState.goodsList,
                    warehousesList: appState.warehousesList,
                    incomingListId: widget.incomingListId,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Image.asset(ImageAssets.incomingGoodsScreen),
                      const Text('چرا هنوز جنسارو نیاوردی داخل؟'),
                    ],
                  ),
                );
        }
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
