import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';

import '../../models/import_models.dart';
import '../../widgets/show_dialog_button.dart';
import '../../widgets/show_dialog_screen.dart';

class CreateOrUpdateIncomingListScreen extends StatelessWidget {
  final TextEditingController boxNumberController;
  final TextEditingController brandNameController;
  final TextEditingController brandIdController;
  const CreateOrUpdateIncomingListScreen({
    Key? key,
    required this.boxNumberController,
    required this.brandNameController,
    required this.brandIdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<AppBloc, AppState>(builder: (context, brandsState) {
      if (brandsState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (brandsState is DisplayAppState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'لطفا تعداد جعبه های ورودی و برند محصولات را وارد کنید و دکمه ثبت را بزنید...',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: boxNumberController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('تعداد جعبه'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'تعداد جعبه های ورودی را وارد نکردید!';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withOpacity(.3),
                  ),
                  onPressed: () {
                    showBrandsDialog(context, brandsState, width)
                        .then((returnValue) {
                      log('value is $returnValue');
                      if (returnValue != null) {
                        brandNameController.text = returnValue[1];
                        final List<BrandsModel> cashedBrands =
                            brandsState.brandsList;
                        final BrandsModel chosenBrand = cashedBrands.firstWhere(
                            (element) =>
                                element.brandName == brandNameController.text);
                        brandIdController.text = chosenBrand.brandId.toString();
                      }
                    });
                  },
                  child: brandNameController.text.isEmpty
                      ? const Text(
                          'هنوز برند انتخاب نشده',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        )
                      : Text(
                          brandNameController.text,
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: brandNameController.text.isNotEmpty &&
                                boxNumberController.text.isNotEmpty &&
                                brandIdController.text.isNotEmpty
                            ? () {
                                context.read<AppBloc>().add(
                                      AddIncomingList(
                                        addIncomingListItem: IncomingListModel(
                                          brandId: int.parse(
                                            brandIdController.text,
                                          ),
                                          numOfBoxes: int.parse(
                                            boxNumberController.text,
                                          ),
                                          incomingListDate: DateTime.now(),
                                        ),
                                      ),
                                    );
                                Navigator.of(context).pop();
                                boxNumberController.clear();
                                brandNameController.clear();
                                brandIdController.clear();
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
