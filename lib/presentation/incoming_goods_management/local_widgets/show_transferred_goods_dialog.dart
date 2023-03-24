import 'package:flutter/material.dart';
import 'package:persian/persian.dart';

import '../../../bloc/bloc_exports.dart';
import '../../../models/import_models.dart';
import '../../resources/import_resources.dart';
import '../create_or_update_incoming_goods_screen.dart';

void _showEditIncomeGoodBottomSheet({
  required BuildContext context,
  required GoodsModel incomeGood,
  required BrandsModel brand,
  required int incomingListId,
  required CountedIncomingsModel countedIncomingGood,
}) {
  showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CreateOrUpdateIncomingGoodsScreen(
          brandItem: brand,
          goodItem: incomeGood,
          incomingListId: incomingListId,
          countedIncomingGood: countedIncomingGood,
        ),
      ),
    ),
  );
}

Future<dynamic> showTransferredGoodsDialog({
  required BuildContext context,
  required GoodsModel good,
  required WarehousesModel warehouse,
  required BrandsModel brand,
  required CountedIncomingsModel countedIncomingGood,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final double width = MediaQuery.of(context).size.width;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          elevation: 5,
          backgroundColor: ColorManager.background.withOpacity(.8),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: width * .2,
                          width: width * .2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorManager.primaryContainer,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              brand.brandName,
                              style: TextStyle(
                                color: ColorManager.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            height: width * .2,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ColorManager.secondary,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      good.goodName,
                                      style: TextStyle(
                                        color: ColorManager.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      warehouse.warehouseName,
                                      style: TextStyle(
                                        color: ColorManager.onPrimaryContainer
                                            .withOpacity(.6),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorManager.primaryContainer,
                          foregroundColor: ColorManager.primary,
                          child: const Icon(Icons.pages_rounded),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: countedIncomingGood.withBoxes != null
                              ? Text(
                                  'ورود ${countedIncomingGood.withBoxes.toString().withPersianNumbers()} جعبه',
                                  style: TextStyle(
                                    color: ColorManager.onBackground,
                                  ),
                                )
                              : Text(
                                  'کالا به صورت کلی (جعبه ای) نداریم',
                                  style: TextStyle(
                                    color: ColorManager.onBackground,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorManager.primaryContainer,
                          foregroundColor: ColorManager.primary,
                          child: const Icon(Icons.auto_awesome_mosaic_outlined),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: countedIncomingGood.withoutBox != 0
                              ? Text(
                                  'ورود ${countedIncomingGood.withoutBox.toString().withPersianNumbers()} عدد',
                                  style: TextStyle(
                                    color: ColorManager.onBackground,
                                  ),
                                )
                              : Text(
                                  'کالای دانه ای نداریم',
                                  style: TextStyle(
                                    color: ColorManager.onBackground,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showEditIncomeGoodBottomSheet(
                                context: context,
                                incomeGood: good,
                                brand: brand,
                                incomingListId: countedIncomingGood.incomingsId,
                                countedIncomingGood: countedIncomingGood,
                              );
                            },
                            icon: const Icon(Icons.save_as_rounded),
                            label: const Text('میخوام اینو ویرایش کنم'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.error,
                            foregroundColor: ColorManager.onError,
                          ),
                          onPressed: () {
                            context.read<AppBloc>().add(
                                  DeleteCountedIncomings(
                                      deleteCountedIncomingItem:
                                          countedIncomingGood),
                                );

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: const Text('حذف'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          backgroundColor: ColorManager.primary.withOpacity(.7),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: ColorManager.onPrimary.withOpacity(.7),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
