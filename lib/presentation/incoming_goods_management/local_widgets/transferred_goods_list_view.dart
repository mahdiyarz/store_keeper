import 'dart:core';

import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/presentation/incoming_goods_management/local_widgets/show_transferred_goods_dialog.dart';

import '../../../models/import_models.dart';
import '../../resources/import_resources.dart';

class TransferredGoodsListView extends StatefulWidget {
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

  @override
  State<TransferredGoodsListView> createState() =>
      _TransferredGoodsListViewState();
}

class _TransferredGoodsListViewState extends State<TransferredGoodsListView> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
        final thisTransferredGood = widget.goodsList.firstWhere(
            (element) => element.id == widget.transferredGoods[index].goodId);

        final thisGoodBrand = widget.brandsList.firstWhere((element) =>
            element.id ==
            thisTransferredGood
                .brandId); //*This method find the brand of each incoming item

        final thisWarehouseGoodIn = widget.warehousesList.firstWhere((element) =>
            element.id ==
            widget.transferredGoods[index]
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
              onTap: () => showTransferredGoodsDialog(
                context: context,
                good: thisTransferredGood,
                brand: thisGoodBrand,
                warehouse: thisWarehouseGoodIn,
                countedIncomingGood: widget.transferredGoods[index],
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
                        thisGoodBrand.name,
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
                              thisTransferredGood.name,
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
                              thisTransferredGood.latin,
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
                                  'ورود ${widget.transferredGoods[index].totalCounted.toString().withPersianNumbers()} عدد به انبار ${thisWarehouseGoodIn.name}',
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
                                  '${widget.transferredGoods[index].price.toString().withPersianNumbers()} ریال',
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
      itemCount: widget.transferredGoods.length,
    );
  }
}
