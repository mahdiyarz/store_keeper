import 'package:flutter/material.dart';

import '../models/import_models.dart';
import '../presentation/resources/import_resources.dart';

class GoodsListView extends StatelessWidget {
  final List<BrandsModel> brandsList;
  final List<GoodsModel> goodsList;
  final double width;
  const GoodsListView({
    Key? key,
    required this.width,
    required this.brandsList,
    required this.goodsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
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
              onTap: () {
                // Navigator.of(context).pushReplacementNamed(
                //   Routes.incomingGoodsManagementRoute,
                //   arguments: IncomingGoodsManagementScreen(
                //     title: incomingItemsBrand.brandName,
                //     boxNumber: incomingList[index].numOfBoxes,
                //     dateTime: incomingList[index].incomingListDate,
                //   ),
                // );
                // Navigator.of(context).pushNamed(
                //   '/arrival-goods-manage',
                //   arguments: IncomingGoodsManagementScreen(
                //     title: arrivalGoodsBrand.brandName,
                //     boxNumber: value
                //         .arrivalGoodsItems[index]
                //         .numOfBoxes,
                //     dateTime: value.arrivalGoodsItems[index]
                //         .arrivalGoodsDate,
                //   ),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.center,
                    height: width * .15,
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
                          const SizedBox(height: 5),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'تعداد در هر جعبه: ${goodsList[index].numInBox}',
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
