import 'dart:core';

import 'package:flutter/material.dart';
import 'package:persian/persian.dart';

import '../models/import_models.dart';
import '../presentation/incoming_goods_management/create_or_update_incoming_goods_screen.dart';
import '../presentation/resources/import_resources.dart';

class TransferredGoodsListView extends StatelessWidget {
  final List<CountedIncomingsModel> transferredGoods;
  final List<BrandsModel> brandsList;
  final List<WarehousesModel> warehousesList;
  final List<GoodsModel> goodsList;
  final int incomingListId;
  const TransferredGoodsListView({
    Key? key,
    required this.transferredGoods,
    required this.brandsList,
    required this.warehousesList,
    required this.goodsList,
    required this.incomingListId,
  }) : super(key: key);

  void _showAddIncomeGoodBottomSheet({
    required BuildContext context,
    required GoodsModel addingIncomeGood,
    required BrandsModel brand,
    required WarehousesModel warehouse,
    required int incomingListId,
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
            goodItem: addingIncomeGood,
            warehouseItem: warehouse,
            incomingListId: incomingListId,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showTransferredGoodsDialog({
    required BuildContext context,
    required String goodName,
    required String warehouseName,
    required String brandName,
    required int? withBox,
    required int withoutBox,
    required int price,
    required int totalCounted,
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                brandName,
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
                                        goodName,
                                        style: TextStyle(
                                          color:
                                              ColorManager.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        warehouseName,
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
                            child: withBox != null
                                ? Text(
                                    'ورود ${withBox.toString().withPersianNumbers()} جعبه',
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
                            child:
                                const Icon(Icons.auto_awesome_mosaic_outlined),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: withoutBox != 0
                                ? Text(
                                    'ورود ${withoutBox.toString().withPersianNumbers()} عدد',
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
                                // _showModalBottomSheet(
                                //     context: context, oldGood: goodsModel);
                              },
                              icon: const Icon(Icons.save_as_rounded),
                              label: const Text('میخوام ویرایشش کنم'),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor:
                                ColorManager.primary.withOpacity(.7),
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

  // extension ConvertToRial on String {
  //   static String convertToRial(String cost){
  //     if (cost.length >= 3) {
  //       for (var i = 0; i < cost.length; i++) {
  //         if (condition) {

  //         }
  //       }

  //     } else{
  //       return cost;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
        // if (isAdding == false && countedGoodsList != null) {
        //   final CountGoodsModel countGoodsModel = countedGoodsList![index];
        //   final int numberOfGoodsInBox = goodsList
        //       .firstWhere(
        //           (element) => element.goodId == countGoodsModel.goodsId)
        //       .numInBox;

        // final int totalCounted =
        //     (numberOfGoodsInBox * countGoodsModel.numOfBox!.toInt()) +
        //         countGoodsModel.numOfSeed!.toInt();
        // }
        final thisTransferredGood = goodsList.firstWhere(
            (element) => element.goodId == transferredGoods[index].goodId);

        final thisGoodBrand = brandsList.firstWhere((element) =>
            element.brandId ==
            thisTransferredGood
                .brandId); //*This method find the brand of each incoming item

        final thisWarehouseGoodIn = warehousesList.firstWhere((element) =>
            element.warehouseId ==
            transferredGoods[index]
                .warehouseId); //*This method find the warehouse of each incoming item

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.shadow.withOpacity(.5),
                blurRadius: 55,
                offset: const Offset(3, 15),
                spreadRadius: 3,
              ),
            ],
          ),
          child: PhysicalModel(
            color: ColorManager.primaryContainer,
            elevation: 2,
            shadowColor: ColorManager.shadow,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(20),
            ),
            child: InkWell(
              onTap: () => _showTransferredGoodsDialog(
                context: context,
                goodName: thisTransferredGood.goodName,
                brandName: thisGoodBrand.brandName,
                warehouseName: thisWarehouseGoodIn.warehouseName,
                withBox: transferredGoods[index].withBoxes!,
                withoutBox: transferredGoods[index].withoutBox,
                totalCounted: transferredGoods[index].totalCounted,
                price: transferredGoods[index].price,
              ),
              //  _showAddIncomeGoodBottomSheet(
              //   context: context,
              //   addingIncomeGood: goodsList[index],
              //   brand: thisGoodBrand,
              //   warehouse: thisWarehouseGoodIn,
              //   incomingListId: incomingListId,
              // ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.center,
                    height: width * .175,
                    width: width * .15,
                    decoration: BoxDecoration(
                      color: ColorManager.secondary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        thisGoodBrand.brandName,
                        style: TextStyle(
                          color: ColorManager.onSecondary,
                          fontSize: FontSize.s10,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              thisTransferredGood.goodName,
                              style: TextStyle(
                                color: ColorManager.onPrimaryContainer,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              thisTransferredGood.goodLatinName,
                              style: TextStyle(
                                color: ColorManager.onPrimaryContainer
                                    .withOpacity(.8),
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'ورود ${transferredGoods[index].totalCounted.toString().withPersianNumbers()} عدد به انبار ${thisWarehouseGoodIn.warehouseName}',
                                  style: TextStyle(
                                    color: ColorManager.onPrimaryContainer
                                        .withOpacity(.7),
                                    fontSize: FontSize.s12,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${transferredGoods[index].price.toString().withPersianNumbers()} ریال',
                                  style: TextStyle(
                                    color: ColorManager.onPrimaryContainer
                                        .withOpacity(.7),
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: transferredGoods.length,
    );
  }
}
