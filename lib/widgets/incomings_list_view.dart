import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/models/persons_model.dart';
import 'package:store_keeper/presentation/incoming_goods_management/tab_incoming_goods_management_screen.dart';
import 'package:store_keeper/presentation/incoming_list/create_or_update_incoming_list_screen.dart';

import '../models/import_models.dart';
import '../presentation/resources/import_resources.dart';

class IncomingsListView extends StatelessWidget {
  final List<PersonsModel> personsList;
  final List<IncomingsModel> incomings;
  final double width;
  const IncomingsListView({
    Key? key,
    required this.width,
    required this.personsList,
    required this.incomings,
  }) : super(key: key);

  void _showModalBottomSheet({
    required BuildContext context,
    required IncomingsModel oldIncomingList,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateIncomingListScreen(
            oldIncomingList: oldIncomingList,
            personsList: personsList,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      itemBuilder: (context, index) {
        final incomingItemsBrand = personsList.firstWhere((element) =>
            element.personId ==
            incomings[index]
                .personId); //*This method find the brand of each incoming item

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
                Navigator.of(context).pushReplacementNamed(
                  Routes.tabIncomingGoodsRoute,
                  arguments: TabIncomingGoodsManagementScreen(
                    title: incomingItemsBrand.personName,
                    boxNumber: incomings[index].boxes,
                    dateTime: incomings[index].incomingDate,
                    incomingGoodId: incomings[index].incomingId!,
                  ),
                );
              },
              onDoubleTap: () {
                _showModalBottomSheet(
                  context: context,
                  oldIncomingList: incomings[index],
                );
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
                      child: Text(
                        incomingItemsBrand.personName,
                        style: TextStyle(
                          color: ColorManager.onSecondary,
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
                              'ورود ${incomings[index].boxes.toString().withPersianNumbers()} جعبه به انبار',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorManager.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            child: Text(
                              'در تاریخ ${incomings[index].incomingDate.toPersian().toString()}',
                              style: TextStyle(
                                  color: ColorManager.onPrimaryContainer
                                      .withOpacity(.7)),
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
      itemCount: incomings.length,
    );
  }
}
