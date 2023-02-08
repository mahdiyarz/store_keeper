import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';

import '../../bloc/incoming_list_bloc/incoming_list_bloc.dart';
import '../../models/import_models.dart';
import '../brands/create_or_update_brand_screen.dart';

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

  void _showModalBottomSheet(BuildContext context, {BrandsModel? brandsModel}) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateBrandScreen(oldBrand: brandsModel),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<BrandsBloc, BrandsState>(
        builder: (context, brandsState) {
      if (brandsState is BrandsStateInitial) {
        context.read<BrandsBloc>().add(const FetchBrands());
      }
      if (brandsState is DisplayBrandsState) {
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
                    if (brandsState is DisplayBrandsState) {
                      showDialog(
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
                                Container(
                                  width: width * .5,
                                  height: width * .8,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: brandsState.brandsList.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'هنوز هیچ برندی ثبت نشده است!',
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : GridView.builder(
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: width * .3,
                                            childAspectRatio: 1.2,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                          ),
                                          itemCount:
                                              brandsState.brandsList.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(.3)),
                                            child: Center(
                                              child: ListTile(
                                                title: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      brandsState
                                                          .brandsList[index]
                                                          .brandName,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                subtitle: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      brandsState
                                                          .brandsList[index]
                                                          .brandLatinName,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                onLongPress: () {
                                                  Navigator.of(context).pop();
                                                  _showModalBottomSheet(context,
                                                      brandsModel: brandsState
                                                          .brandsList[index]);
                                                },
                                                onTap: () =>
                                                    Navigator.pop(context, [
                                                  brandsState.brandsList[index]
                                                      .brandId,
                                                  brandsState.brandsList[index]
                                                      .brandName,
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _showModalBottomSheet(context);
                                    },
                                    icon: const Icon(Icons.edit_note_rounded,
                                        size: 18),
                                    label: const Text('ایجاد برند جدید'),
                                    style: ElevatedButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ).then((returnValue) {
                        log('value is $returnValue');
                        if (returnValue != null) {
                          brandNameController.text = returnValue[1];
                          final List<BrandsModel> cashedBrands =
                              brandsState.brandsList;
                          final BrandsModel chosenBrand =
                              cashedBrands.firstWhere((element) =>
                                  element.brandName ==
                                  brandNameController.text);
                          brandIdController.text =
                              chosenBrand.brandId.toString();
                        }
                      });
                    }
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
                                context.read<IncomingListBloc>().add(
                                      AddIncomingLists(
                                        addIncomingList: IncomingListModel(
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
}
