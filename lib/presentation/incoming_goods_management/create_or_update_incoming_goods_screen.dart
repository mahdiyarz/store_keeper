import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/show_dialog_button.dart';
import '../../widgets/show_dialog_screen.dart';

class CreateOrUpdateIncomingGoodsScreen extends StatefulWidget {
  final BrandsModel brandName;
  final GoodsModel goodName;
  final int incomingListId;
  const CreateOrUpdateIncomingGoodsScreen({
    required this.brandName,
    required this.goodName,
    required this.incomingListId,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateOrUpdateIncomingGoodsScreen> createState() =>
      _CreateOrUpdateIncomingGoodsScreenState();
}

class _CreateOrUpdateIncomingGoodsScreenState
    extends State<CreateOrUpdateIncomingGoodsScreen> {
  TextEditingController boxNumberController = TextEditingController();
  TextEditingController seedNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController incomingIdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // if (widget.oldIncomingList != null) {
    //   boxNumberController.text = widget.oldIncomingList!.numOfBoxes.toString();
    //   final String brandName = widget.brandsList!
    //       .firstWhere(
    //           (element) => element.brandId == widget.oldIncomingList!.brandId)
    //       .brandName;
    //   brandNameController.text = brandName;
    //   brandIdController.text = widget.oldIncomingList!.brandId.toString();
    // }

    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      if (appState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (appState is DisplayAppState) {
        return Form(
          key: _formKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${widget.goodName.goodName} ${widget.brandName.brandName}',
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
                    controller: boxNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: ColorManager.error.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 0),
                            color: ColorManager.onError,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      label: const Text('چند کارتن؟'),
                      border: const OutlineInputBorder(),
                      hintText: 'تعداد کارتن های کامل',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: seedNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: ColorManager.error.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 0),
                            color: ColorManager.onError,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      label: const Text('چند عدد؟'),
                      hintText: 'تعداد بدون کارتن',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: ColorManager.error.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 0),
                            color: ColorManager.onError,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      label: const Text('قیمتش چقدره؟'),
                      hintText: 'به ریال...',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (boxNumberController.text.isEmpty &&
                                seedNumberController.text.isEmpty &&
                                priceController.text.isEmpty) {
                              return;
                            } else {
                              final int goodsId = widget.goodName.goodId!;
                              context.read<AppBloc>().add(
                                    AddCountGood(
                                      countedGood: CountGoodsModel(
                                        numOfBox:
                                            boxNumberController.text.isEmpty
                                                ? 0
                                                : int.tryParse(
                                                    boxNumberController.text),
                                        numOfSeed:
                                            seedNumberController.text.isEmpty
                                                ? 0
                                                : int.tryParse(
                                                    seedNumberController.text),
                                        price: priceController.text.isEmpty
                                            ? 0
                                            : int.tryParse(
                                                priceController.text),
                                        goodsId: goodsId,
                                        incomingListId: widget.incomingListId,
                                        lakingId: null,
                                      ),
                                    ),
                                  );
                              Navigator.of(context).pop();
                              clearTextControllers();
                            }
                            // if (_formKey.currentState!.validate()) {
                            //   if (brandNameController.text.isNotEmpty &&
                            //       boxNumberController.text.isNotEmpty &&
                            //       brandIdController.text.isNotEmpty) {
                            //     const snackBar = SnackBar(
                            //       dismissDirection: DismissDirection.up,
                            //       content:
                            //           // widget.oldIncomingList != null
                            //           //     ? const Text(
                            //           //         'به خوبی ویرایشش کردی',
                            //           //         textAlign: TextAlign.center,
                            //           //       )
                            //           //     :
                            //           Text(
                            //         'یکی دیگه به لیست اضافه شد',
                            //         textAlign: TextAlign.center,
                            //       ),
                            //       duration: Duration(
                            //         seconds: 2,
                            //       ),
                            //     );
                            //     // widget.oldIncomingList != null
                            //     //     ? context.read<AppBloc>().add(
                            //     //           EditIncomingList(
                            //     //             oldIncomingListId: widget
                            //     //                 .oldIncomingList!
                            //     //                 .incomingListId!,
                            //     //             newIncomingListItem:
                            //     //                 IncomingListModel(
                            //     //                     brandId: int.parse(
                            //     //                         brandIdController.text),
                            //     //                     numOfBoxes:
                            //     //                         int.parse(
                            //     //                             boxNumberController
                            //     //                                 .text),
                            //     //                     incomingListDate: widget
                            //     //                         .oldIncomingList!
                            //     //                         .incomingListDate),
                            //     //           ),
                            //     //         )
                            //     //     :
                            //     context.read<AppBloc>().add(
                            //           AddIncomingList(
                            //             addIncomingListItem: IncomingListModel(
                            //               brandId: int.parse(
                            //                 brandIdController.text,
                            //               ),
                            //               numOfBoxes: int.parse(
                            //                 boxNumberController.text,
                            //               ),
                            //               incomingListDate: DateTime.now(),
                            //             ),
                            //           ),
                            //         );
                            //     Navigator.of(context).pop();
                            //     clearTextControllers();
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar);
                            //   }
                            // }
                          },
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
                      // if (widget.oldIncomingList != null)
                      //   const SizedBox(width: 5),
                      // if (widget.oldIncomingList != null)
                      //   ElevatedButton(
                      //     onPressed: () {
                      //       context.read<AppBloc>().add(
                      //             DeleteIncomingList(
                      //                 deleteIncomingListItem:
                      //                     widget.oldIncomingList!),
                      //           );
                      //       Navigator.of(context).pop();
                      //       clearTextControllers();
                      //       ScaffoldMessenger.of(context)
                      //           .showSnackBar(const SnackBar(
                      //         dismissDirection: DismissDirection.up,
                      //         content: Text(
                      //           'این ورودی از لیستت حذف شد',
                      //           textAlign: TextAlign.center,
                      //         ),
                      //         duration: Duration(
                      //           seconds: 2,
                      //         ),
                      //       ));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: ColorManager.error,
                      //       foregroundColor: ColorManager.onError,
                      //     ),
                      //     child: const Text('حذف'),
                      //   ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const Text('data');
    });
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
                ? const Text('برند خود را انتخاب کنید',
                    textAlign: TextAlign.center)
                : null,
            children: [
              ShowDialogScreen(
                width: width,
                personsList: appState.personsList,
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

  void clearTextControllers() {
    boxNumberController.clear();
    seedNumberController.clear();
    priceController.clear();
  }
}
