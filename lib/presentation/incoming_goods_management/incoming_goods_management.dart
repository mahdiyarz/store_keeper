import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/incoming_goods_management/create_or_update_incoming_goods_screen.dart';

import '../../models/import_models.dart';

class IncomingGoodsManagementScreen extends StatelessWidget {
  const IncomingGoodsManagementScreen({
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet(
      BuildContext context, GoodsModel goodName, BrandsModel brandName) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateIncomingGoodsScreen(
            brandName: brandName,
            goodName: goodName,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return const Center(
      child: Text('dsfsd'),
    );
  }
}
