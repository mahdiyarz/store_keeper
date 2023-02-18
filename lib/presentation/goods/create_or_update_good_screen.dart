import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/show_dialog_button.dart';
import '../../widgets/show_dialog_screen.dart';

class CreateOrUpdateGoodScreen extends StatelessWidget {
  final TextEditingController goodNameController;
  final TextEditingController goodLatinNameController;
  final TextEditingController numberInBoxController;
  final TextEditingController brandNameController;
  final TextEditingController? barcodeController;
  final TextEditingController? accountingCodeController;
  final TextEditingController brandIdController;
  const CreateOrUpdateGoodScreen({
    Key? key,
    required this.goodNameController,
    required this.goodLatinNameController,
    required this.numberInBoxController,
    required this.brandNameController,
    this.barcodeController,
    this.accountingCodeController,
    required this.brandIdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<AppBloc, AppState>(builder: (context, goodState) {
      if (goodState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (goodState is DisplayAppState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'لطفا موارد مورد نیاز را کامل کنید و دکمه ثبت را بزنید...',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorManager.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: goodNameController,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    label: Text('نام کالا'),
                    hintText: 'به فارسی تایپ کنید...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'نام کالا را وارد نکردید!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    controller: goodLatinNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Goods Name'),
                      hintText: 'Type in English...',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'نام کالا را وارد نکردید!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: numberInBoxController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('تعداد در هر جعبه'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'تعداد در هر جعبه را وارد نکردید!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: barcodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('بارکد کالا (اختیاری)'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: accountingCodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('کد سیستم حسابداری (اختیاری)'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    backgroundColor: ColorManager.secondary,
                  ),
                  onPressed: () {
                    showBrandsDialog(context, goodState, width)
                        .then((returnValue) {
                      log('value is $returnValue');
                      if (returnValue != null) {
                        brandNameController.text = returnValue[1];
                        final List<BrandsModel> cashedBrands =
                            goodState.brandsList;
                        final BrandsModel chosenBrand = cashedBrands.firstWhere(
                            (element) =>
                                element.brandName == brandNameController.text);
                        brandIdController.text = chosenBrand.brandId.toString();
                      }
                    });
                  },
                  child: brandNameController.text.isEmpty
                      ? Text(
                          'هنوز برند انتخاب نشده',
                          style: TextStyle(
                            color: ColorManager.onSecondary,
                          ),
                        )
                      : Text(
                          brandNameController.text,
                          style: TextStyle(
                            color: ColorManager.onSecondary,
                          ),
                        ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: goodNameController.text.isNotEmpty &&
                                goodLatinNameController.text.isNotEmpty &&
                                brandNameController.text.isNotEmpty &&
                                numberInBoxController.text.isNotEmpty &&
                                brandIdController.text.isNotEmpty
                            ? () {
                                context.read<AppBloc>().add(
                                      AddGood(
                                        good: GoodsModel(
                                          goodName: goodNameController.text,
                                          goodLatinName:
                                              goodLatinNameController.text,
                                          brandId:
                                              int.parse(brandIdController.text),
                                          numInBox: int.parse(
                                              numberInBoxController.text),
                                          barcode: int.tryParse(
                                              barcodeController!.text),
                                        ),
                                      ),
                                    );
                                Navigator.of(context).pop();
                                goodNameController.clear();
                                goodLatinNameController.clear();
                                numberInBoxController.clear();
                                brandNameController.clear();
                                brandIdController.clear();
                                barcodeController!.clear();
                              }
                            : null,
                        child: const Text('ثبت'),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('انصراف'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      return const Text('data');
    });
  }

  Future<dynamic> showBrandsDialog(
      BuildContext context, DisplayAppState brandsState, double width) {
    return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: brandsState.brandsList.isNotEmpty
                ? const Text('برند خود را انتخاب کنید',
                    textAlign: TextAlign.center)
                : null,
            children: [
              ShowDialogScreen(
                width: width,
                brandsList: brandsState.brandsList,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: ShowDialogButton(),
              )
            ],
          ),
        );
      },
    );
  }
}
