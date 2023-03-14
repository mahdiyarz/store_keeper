import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/presentation/goods/create_or_update_good_screen.dart';
import 'package:store_keeper/presentation/incoming_goods_management/create_or_update_incoming_goods_screen.dart';

import '../models/import_models.dart';
import '../presentation/resources/import_resources.dart';

class GoodsListView extends StatelessWidget {
  final List<BrandsModel> brandsList;
  final List<GoodsModel> goodsList;
  final List<CountGoodsModel>? countedGoodsList;
  final int? incomingListId;
  final bool isAdding;
  final double width;
  const GoodsListView({
    Key? key,
    required this.width,
    required this.brandsList,
    required this.goodsList,
    required this.isAdding,
    this.incomingListId,
    this.countedGoodsList,
  }) : super(key: key);

  void _showModalBottomSheet({
    required BuildContext context,
    required GoodsModel oldGood,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateGoodScreen(
            oldGood: oldGood,
            brandsList: brandsList,
          ),
        ),
      ),
    );
  }

  void _showAddIncomeGoodBottomSheet({
    required BuildContext context,
    required GoodsModel addingIncomeGood,
    required BrandsModel brand,
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
            brandName: brand,
            goodName: addingIncomeGood,
            incomingListId: incomingListId,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showGoodsDialog(
    BuildContext context,
    double width,
    GoodsModel goodsModel,
    BrandsModel brandName,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
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
                            height: width * .3,
                            width: width * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ColorManager.primaryContainer,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    brandName.brandName,
                                    style: TextStyle(
                                      color: ColorManager.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    brandName.brandLatinName,
                                    style: TextStyle(
                                      color: ColorManager.onPrimaryContainer
                                          .withOpacity(.6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: ColorManager.error,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.contact_support_rounded,
                                      color: ColorManager.onError,
                                      size: 45,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'با جعبه های ${goodsModel.numInBox.toString().withPersianNumbers()}تایی',
                                        style: TextStyle(
                                          color: ColorManager.onError,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      Container(
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
                                  goodsModel.goodName,
                                  style: TextStyle(
                                    color: ColorManager.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  goodsModel.goodLatinName,
                                  style: TextStyle(
                                    color: ColorManager.onPrimaryContainer
                                        .withOpacity(.6),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorManager.primaryContainer,
                            foregroundColor: ColorManager.primary,
                            child: const Icon(Icons.qr_code_2_rounded),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: goodsModel.barcode != null
                                ? Text(
                                    goodsModel.barcode.toString(),
                                    style: TextStyle(
                                      color: ColorManager.onBackground,
                                    ),
                                  )
                                : Text(
                                    'بارکد برای این کالا ثبت نشده',
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
                            child: const Icon(Icons.account_tree_rounded),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: goodsModel.accountingCode != null
                                ? Text(
                                    goodsModel.accountingCode
                                        .toString()
                                        .withPersianNumbers(),
                                    style: TextStyle(
                                      color: ColorManager.onBackground,
                                    ),
                                  )
                                : Text(
                                    'کد سیستم مالی ثبت نشده',
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
                                _showModalBottomSheet(
                                    context: context, oldGood: goodsModel);
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
        if (isAdding == false && countedGoodsList != null) {
          final CountGoodsModel countGoodsModel = countedGoodsList![index];
          final int numberOfGoodsInBox = goodsList
              .firstWhere(
                  (element) => element.goodId == countGoodsModel.goodsId)
              .numInBox;

          final int totalCounted =
              (numberOfGoodsInBox * countGoodsModel.numOfBox!.toInt()) +
                  countGoodsModel.numOfSeed!.toInt();
        }
        final thisGoodBrand = brandsList.firstWhere((element) =>
            element.brandId ==
            goodsList[index]
                .brandId); //*This method find the brand of each incoming item
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
              onDoubleTap: () => _showModalBottomSheet(
                context: context,
                oldGood: goodsList[index],
              ),
              onTap: () => isAdding == false
                  ? _showGoodsDialog(
                      context,
                      width,
                      goodsList[index],
                      thisGoodBrand,
                    )
                  : _showAddIncomeGoodBottomSheet(
                      context: context,
                      addingIncomeGood: goodsList[index],
                      brand: thisGoodBrand,
                      incomingListId: incomingListId!,
                    ),
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
                              goodsList[index].goodName,
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
                              goodsList[index].goodLatinName,
                              style: TextStyle(
                                color: ColorManager.onPrimaryContainer
                                    .withOpacity(.8),
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          isAdding == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'تعداد در هر جعبه: ${goodsList[index].numInBox.toString().withPersianNumbers()}',
                                        style: TextStyle(
                                          color: ColorManager.onPrimaryContainer
                                              .withOpacity(.7),
                                          fontSize: FontSize.s12,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: BoxDecoration(
                                            color: ColorManager.secondary,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                'بارکد',
                                                style: TextStyle(
                                                  color:
                                                      ColorManager.onSecondary,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              goodsList[index].barcode != null
                                                  ? Icon(
                                                      Icons.done_rounded,
                                                      size: 10,
                                                      color:
                                                          ColorManager.primary,
                                                    )
                                                  : Icon(
                                                      Icons.clear_rounded,
                                                      size: 10,
                                                      color: ColorManager.error,
                                                    ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: BoxDecoration(
                                            color: ColorManager.secondary,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                'کدینگ',
                                                style: TextStyle(
                                                  color:
                                                      ColorManager.onSecondary,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              goodsList[index].accountingCode !=
                                                      null
                                                  ? Icon(
                                                      Icons.done_rounded,
                                                      size: 10,
                                                      color:
                                                          ColorManager.primary,
                                                    )
                                                  : Icon(
                                                      Icons.clear_rounded,
                                                      size: 10,
                                                      color: ColorManager.error,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'تعداد کل ورودی: ',
                                    style: TextStyle(
                                      color: ColorManager.onPrimaryContainer
                                          .withOpacity(.7),
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
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
      itemCount: goodsList.length,
    );
  }
}
