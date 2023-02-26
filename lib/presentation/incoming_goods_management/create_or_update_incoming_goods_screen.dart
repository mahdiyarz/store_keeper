import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/show_dialog_button.dart';
import '../../widgets/show_dialog_screen.dart';

class CreateOrUpdateIncomingGoodsScreen extends StatefulWidget {
  final BrandsModel brandName;
  final GoodsModel goodName;
  const CreateOrUpdateIncomingGoodsScreen({
    required this.brandName,
    required this.goodName,
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
  TextEditingController goodIdController = TextEditingController();
  TextEditingController goodNameController = TextEditingController();
  TextEditingController incomingIdController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandIdController = TextEditingController();

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
                    'مشخصات کالای وارد شده رو وارد کنید...',
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
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: ColorManager.primary,
                      ),
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
                      hintText: 'سرچ کن...',
                      border: const OutlineInputBorder(),
                    ),
                    // onChanged: (value) => searchSpecificGood(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'اصل کاری همینه، با دقت انتخاب کن...';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 5,
                    ),
                    width: width,
                    height: width * .7,
                    decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        // filteredGoods.isNotEmpty
                        //     ? GridView.builder(
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 2,
                        //           childAspectRatio: 2.5,
                        //           crossAxisSpacing: 5,
                        //           mainAxisSpacing: 5,
                        //         ),
                        //         controller: ScrollController(),
                        //         physics: const ScrollPhysics(),
                        //         itemCount: filteredGoods.length,
                        //         itemBuilder: (context, index) {
                        //           log(filteredGoods.length.toString());
                        //           return Container(
                        //             decoration: BoxDecoration(
                        //               color: ColorManager.primaryContainer,
                        //               borderRadius: const BorderRadius.all(
                        //                   Radius.circular(8)),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: ColorManager.shadow,
                        //                   blurRadius: 2,
                        //                   offset: const Offset(0, 0),
                        //                   spreadRadius: 0,
                        //                 ),
                        //               ],
                        //             ),
                        //             child: Center(
                        //               child: ListTile(
                        //                 title: FittedBox(
                        //                     fit: BoxFit.scaleDown,
                        //                     child: Text(
                        //                       filteredGoods[index].goodName,
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .bodyText1,
                        //                     )),
                        //                 subtitle: FittedBox(
                        //                   fit: BoxFit.scaleDown,
                        //                   child: Text(
                        //                     filteredGoods[index].goodLatinName,
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .subtitle2,
                        //                   ),
                        //                 ),
                        //                 onTap: () {},
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       )
                        //     :
                        const Center(
                      child: Text('کالایی با این مشخصات ثبت نشده'),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'تعداد جعبه های ورودی اجباریه!';
                    //   }
                    //   return null;
                    // },
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
                      border: const OutlineInputBorder(),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'تعداد جعبه های ورودی اجباریه!';
                    //   }
                    //   return null;
                    // },
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
                      border: const OutlineInputBorder(),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'تعداد جعبه های ورودی اجباریه!';
                    //   }
                    //   return null;
                    // },
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
                            if (_formKey.currentState!.validate()) {
                              if (brandNameController.text.isNotEmpty &&
                                  boxNumberController.text.isNotEmpty &&
                                  brandIdController.text.isNotEmpty) {
                                const snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  content:
                                      // widget.oldIncomingList != null
                                      //     ? const Text(
                                      //         'به خوبی ویرایشش کردی',
                                      //         textAlign: TextAlign.center,
                                      //       )
                                      //     :
                                      Text(
                                    'یکی دیگه به لیست اضافه شد',
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                );
                                // widget.oldIncomingList != null
                                //     ? context.read<AppBloc>().add(
                                //           EditIncomingList(
                                //             oldIncomingListId: widget
                                //                 .oldIncomingList!
                                //                 .incomingListId!,
                                //             newIncomingListItem:
                                //                 IncomingListModel(
                                //                     brandId: int.parse(
                                //                         brandIdController.text),
                                //                     numOfBoxes:
                                //                         int.parse(
                                //                             boxNumberController
                                //                                 .text),
                                //                     incomingListDate: widget
                                //                         .oldIncomingList!
                                //                         .incomingListDate),
                                //           ),
                                //         )
                                //     :
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
                                clearTextControllers();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
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

  void clearTextControllers() {
    boxNumberController.clear();
    brandNameController.clear();
    brandIdController.clear();
  }
}
