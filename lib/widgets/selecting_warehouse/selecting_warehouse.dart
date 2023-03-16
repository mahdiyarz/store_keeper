import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_keeper/models/import_models.dart';

import 'package:store_keeper/widgets/show_dialog_button.dart';
import 'package:store_keeper/widgets/selecting_warehouse/show_warehouse_dialog_screen.dart';

import '../../bloc/bloc_exports.dart';
import '../../presentation/resources/import_resources.dart';

class SelectingWarehouse extends StatelessWidget {
  final DisplayAppState appState;
  final TextEditingController warehouseNameController;
  final TextEditingController warehouseIdController;

  const SelectingWarehouse({
    Key? key,
    required this.appState,
    required this.warehouseNameController,
    required this.warehouseIdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: ColorManager.primaryContainer,
      ),
      onPressed: () {
        showWarehouseDialog(context, appState, width).then((returnValue) {
          log('value is $returnValue');

          if (returnValue != null) {
            warehouseNameController.text = returnValue[1];
            final List<WarehousesModel> cashedWarehouses =
                appState.warehousesList;
            final WarehousesModel chosenWarehouse = cashedWarehouses.firstWhere(
                (element) =>
                    element.warehouseName == warehouseNameController.text);
            warehouseIdController.text = chosenWarehouse.warehouseId.toString();
          }
        });
      },
      child: Text(
        'کجا میذاریشون؟',
        style: TextStyle(
          color: ColorManager.onPrimaryContainer,
        ),
      ),
    );
  }

  Future<dynamic> showWarehouseDialog(
      BuildContext context, DisplayAppState appState, double width) {
    return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: appState.warehousesList.isNotEmpty
                ? const Text(
                    'انبار مرکزی؟ یا دپو؟',
                    textAlign: TextAlign.center,
                  )
                : null,
            children: [
              ShowWarehouseDialogScreen(
                warehouseList: appState.warehousesList,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: ShowDialogButton(
                  isAddingNewPerson: true,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
