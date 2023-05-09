import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/selecting_brand/selecting_brand.dart';

class CreateOrUpdateGoodScreen extends StatefulWidget {
  final GoodsModel? oldGood;
  final List<BrandsModel>? brandsList;

  const CreateOrUpdateGoodScreen({
    Key? key,
    required this.oldGood,
    required this.brandsList,
  }) : super(key: key);

  @override
  State<CreateOrUpdateGoodScreen> createState() =>
      _CreateOrUpdateGoodScreenState();
}

class _CreateOrUpdateGoodScreenState extends State<CreateOrUpdateGoodScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController goodNameController = TextEditingController();
  TextEditingController goodLatinNameController = TextEditingController();
  TextEditingController numberInBoxController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController accountingCodeController = TextEditingController();
  TextEditingController brandIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.oldGood != null) {
      goodNameController.text = widget.oldGood!.name;
      goodLatinNameController.text = widget.oldGood!.latin;
      numberInBoxController.text = widget.oldGood!.numInBox.toString();
      final String brandName = widget.brandsList!
          .firstWhere((element) => element.id == widget.oldGood!.brandId)
          .name;
      brandNameController.text = brandName;
      brandIdController.text = widget.oldGood!.brandId.toString();
      if (widget.oldGood!.accountingCode != null) {
        accountingCodeController.text =
            widget.oldGood!.accountingCode.toString();
      }
      if (widget.oldGood!.barcode != null) {
        barcodeController.text = widget.oldGood!.barcode.toString();
      }
    }

    return BlocBuilder<AppBloc, AppState>(builder: (context, goodState) {
      if (goodState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (goodState is DisplayAppState) {
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
                      label: const Text('نام کالا'),
                      hintText: 'فارسی شو بنویس...',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'کالای بی نام نداریما! اسمشو بگو...';
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
                        label: const Text('Goods Name'),
                        hintText: 'Type in English...',
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Try it in English dude! I know you can...';
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
                      label: const Text('تعداد در هر جعبه'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'نکنه نمیدونی تو هر جعبه چندتاس؟';
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
                        goodState: goodState,
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
                              if (goodNameController.value.text.isNotEmpty &&
                                  goodLatinNameController
                                      .value.text.isNotEmpty &&
                                  brandNameController.value.text.isNotEmpty &&
                                  numberInBoxController.value.text.isNotEmpty &&
                                  brandIdController.value.text.isNotEmpty) {
                                final snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  content: widget.oldGood != null
                                      ? const Text(
                                          'به خوبی ویرایشش کردی',
                                          textAlign: TextAlign.center,
                                        )
                                      : const Text(
                                          'یکی دیگه به کالاها اضافه شد',
                                          textAlign: TextAlign.center,
                                        ),
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                );
                                widget.oldGood != null
                                    ? context.read<AppBloc>().add(
                                          EditGood(
                                            oldGoodId: widget.oldGood!.id!,
                                            editedGood: GoodsModel(
                                              name: goodNameController.text,
                                              latin:
                                                  goodLatinNameController.text,
                                              brandId: int.parse(
                                                  brandIdController.text),
                                              numInBox: int.parse(
                                                  numberInBoxController.text),
                                              barcode: int.tryParse(
                                                  barcodeController.text),
                                              accountingCode: int.tryParse(
                                                  accountingCodeController
                                                      .text),
                                            ),
                                          ),
                                        )
                                    : context.read<AppBloc>().add(
                                          AddGood(
                                            good: GoodsModel(
                                              name: goodNameController.text,
                                              latin:
                                                  goodLatinNameController.text,
                                              brandId: int.parse(
                                                  brandIdController.text),
                                              numInBox: int.parse(
                                                  numberInBoxController.text),
                                              barcode: int.tryParse(
                                                  barcodeController.text),
                                              accountingCode: int.tryParse(
                                                  accountingCodeController
                                                      .text),
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
                      if (widget.oldGood != null) const SizedBox(width: 5),
                      if (widget.oldGood != null)
                        ElevatedButton(
                          onPressed: () {
                            context.read<AppBloc>().add(
                                  DeleteGood(deletedGood: widget.oldGood!),
                                );
                            Navigator.of(context).pop();
                            clearTextControllers();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              dismissDirection: DismissDirection.up,
                              content: Text(
                                'این کالا از لیستت حذف شد',
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

  void clearTextControllers() {
    goodNameController.clear();
    goodLatinNameController.clear();
    numberInBoxController.clear();
    brandNameController.clear();
    brandIdController.clear();
    barcodeController.clear();
    accountingCodeController.clear();
  }
}
