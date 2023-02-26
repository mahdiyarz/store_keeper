import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/selecting_brand.dart';
import '../../widgets/show_dialog_button.dart';
import '../../widgets/show_dialog_screen.dart';

class CreateOrUpdateIncomingListScreen extends StatelessWidget {
  final IncomingListModel? oldIncomingList;
  final List<BrandsModel>? brandsList;
  CreateOrUpdateIncomingListScreen({
    required this.oldIncomingList,
    required this.brandsList,
    Key? key,
  }) : super(key: key);

  TextEditingController boxNumberController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (oldIncomingList != null) {
      boxNumberController.text = oldIncomingList!.numOfBoxes.toString();
      final String brandName = brandsList!
          .firstWhere((element) => element.brandId == oldIncomingList!.brandId)
          .brandName;
      brandNameController.text = brandName;
      brandIdController.text = oldIncomingList!.brandId.toString();
    }

    return BlocBuilder<AppBloc, AppState>(builder: (context, brandsState) {
      if (brandsState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (brandsState is DisplayAppState) {
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
                    'لطفا تعداد جعبه های ورودی و برند محصولات را وارد کنید و دکمه ثبت را بزنید...',
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
                    autofocus: true,
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
                      label: const Text('تعداد جعبه'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'تعداد جعبه های ورودی اجباریه!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: brandNameController,
                          readOnly: true,
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
                            hintText: 'هنوز برند انتخاب نکردی...',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'اصل کار همین برندشه، با دقت انتخاب کن...';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SelectingBrand(
                        goodState: brandsState,
                        brandNameController: brandNameController,
                        brandIdController: brandIdController,
                      ),
                    ],
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
                                final snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  content: oldIncomingList != null
                                      ? const Text(
                                          'به خوبی ویرایشش کردی',
                                          textAlign: TextAlign.center,
                                        )
                                      : const Text(
                                          'یکی دیگه به لیست اضافه شد',
                                          textAlign: TextAlign.center,
                                        ),
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                );
                                oldIncomingList != null
                                    ? context.read<AppBloc>().add(
                                          EditIncomingList(
                                            oldIncomingListId: oldIncomingList!
                                                .incomingListId!,
                                            newIncomingListItem:
                                                IncomingListModel(
                                                    brandId: int.parse(
                                                        brandIdController.text),
                                                    numOfBoxes:
                                                        int.parse(
                                                            boxNumberController
                                                                .text),
                                                    incomingListDate:
                                                        oldIncomingList!
                                                            .incomingListDate),
                                          ),
                                        )
                                    : context.read<AppBloc>().add(
                                          AddIncomingList(
                                            addIncomingListItem:
                                                IncomingListModel(
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
                      if (oldIncomingList != null) const SizedBox(width: 5),
                      if (oldIncomingList != null)
                        ElevatedButton(
                          onPressed: () {
                            context.read<AppBloc>().add(
                                  DeleteIncomingList(
                                      deleteIncomingListItem: oldIncomingList!),
                                );
                            Navigator.of(context).pop();
                            clearTextControllers();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              dismissDirection: DismissDirection.up,
                              content: Text(
                                'این ورودی از لیستت حذف شد',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(
                                seconds: 2,
                              ),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.error,
                            foregroundColor: ColorManager.onError,
                          ),
                          child: const Text('حذف'),
                        ),
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
