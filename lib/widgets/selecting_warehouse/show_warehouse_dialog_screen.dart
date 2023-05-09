import 'package:flutter/material.dart';
import 'package:store_keeper/models/import_models.dart';
import 'package:store_keeper/presentation/warehouse/local_widgets/create_or_update_warehouse_screen.dart';

class ShowWarehouseDialogScreen extends StatelessWidget {
  final List<WarehousesModel> warehouseList;
  const ShowWarehouseDialogScreen({
    Key? key,
    required this.warehouseList,
  }) : super(key: key);

  void _editingBottomSheet({
    required BuildContext context,
    required WarehousesModel warehousesModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateWarehouseScreen(oldWarehouse: warehousesModel),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
      height: width * .8,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: warehouseList.isEmpty
          ? const Center(
              child: Text(
                'انبار ثبت شده ندارید!',
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width * .3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: warehouseList.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(.3)),
                child: Center(
                  child: ListTile(
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(warehouseList[index].name,
                          style: const TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center),
                    ),
                    onLongPress: () {
                      Navigator.of(context).pop();
                      _editingBottomSheet(
                        context: context,
                        warehousesModel: warehouseList[index],
                      );
                    },
                    onTap: () => Navigator.pop(context, [
                      warehouseList[index].id,
                      warehouseList[index].name,
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
