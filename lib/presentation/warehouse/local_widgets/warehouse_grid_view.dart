import 'package:flutter/material.dart';
import 'package:store_keeper/models/warehouses_model.dart';

import '../../resources/import_resources.dart';
import 'create_or_update_warehouse_screen.dart';

class WarehousesGridView extends StatelessWidget {
  final List<WarehousesModel> warehousesList;
  const WarehousesGridView({
    required this.warehousesList,
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet(
    BuildContext context, {
    WarehousesModel? warehousesModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateWarehouseScreen(
            oldWarehouse: warehousesModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenWidth * .3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: warehousesList.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: ColorManager.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadow,
              blurRadius: 15,
              offset: const Offset(5, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  warehousesList[index].warehouseName,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            onTap: () {
              _showModalBottomSheet(
                context,
                warehousesModel: warehousesList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
