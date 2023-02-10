import 'package:flutter/material.dart';
import 'package:persian/persian.dart';

import '../models/import_models.dart';
import '../presentation/resources/import_resources.dart';

class IncomingListListView extends StatelessWidget {
  final List<BrandsModel> brandsList;
  final List<IncomingListModel> incomingList;
  final double width;
  const IncomingListListView({
    Key? key,
    required this.width,
    required this.brandsList,
    required this.incomingList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
        final incomingItemsBrand = brandsList.firstWhere((element) =>
            element.brandId ==
            incomingList[index]
                .brandId); //*This logic find brand of specific arrival goods

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.shadow,
                blurRadius: 99,
              ),
            ],
          ),
          child: PhysicalModel(
            color: ColorManager.white,
            elevation: 5,
            shadowColor: const Color(0xff040039).withOpacity(.2),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(20),
            ),
            child: InkWell(
              onTap: () {
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
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text(
                        incomingItemsBrand.brandName,
                        style: const TextStyle(
                          color: Colors.black54,
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
                            child: Text(
                              'ورود ${incomingList[index].numOfBoxes.toString().withPersianNumbers()} جعبه به انبار',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            child: Text(
                              'در تاریخ ${incomingList[index].incomingListDate.toPersian().toString()}',
                              style: const TextStyle(color: Colors.black45),
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
      itemCount: incomingList.length,
    );
  }
}
