import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/widgets/selecting_brand/show_brands_dialog_screen.dart';
import 'package:store_keeper/widgets/show_dialog_button.dart';

import '../../bloc/bloc_exports.dart';
import '../../presentation/resources/import_resources.dart';

class SelectingBrand extends StatelessWidget {
  final DisplayAppState goodState;
  final TextEditingController brandNameController;
  final TextEditingController brandIdController;

  const SelectingBrand({
    Key? key,
    required this.goodState,
    required this.brandNameController,
    required this.brandIdController,
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
        showBrandsDialog(context, goodState, width).then((returnValue) {
          log('value is $returnValue');

          if (returnValue != null) {
            brandNameController.text = returnValue[1];
            final List<BrandsModel> cashedBrands = goodState.brandsList;
            final BrandsModel chosenBrand = cashedBrands.firstWhere(
                (element) => element.name == brandNameController.text);
            brandIdController.text = chosenBrand.id.toString();
          }
        });
      },
      child: Text(
        'برندش چیه؟',
        style: TextStyle(
          color: ColorManager.onPrimaryContainer,
        ),
      ),
    );
  }

  Future<dynamic> showBrandsDialog(
      BuildContext context, DisplayAppState appState, double width) {
    return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: appState.brandsList.isNotEmpty
                ? const Text(
                    'برندش رو انتخاب کن',
                    textAlign: TextAlign.center,
                  )
                : null,
            children: [
              ShowBrandsDialogScreen(
                brandsList: appState.brandsList,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: ShowDialogButton(
                  isAddingNewPerson: false,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
