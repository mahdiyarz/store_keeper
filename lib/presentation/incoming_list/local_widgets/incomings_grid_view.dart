import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/presentation/incoming_list/create_or_update_incoming_list_screen.dart';

import '../../../models/import_models.dart';
import '../../incoming_goods_management/tab_incoming_goods_management_screen.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class IncomingsGridView extends StatelessWidget {
  final List<PersonsModel> personsList;
  final List<IncomingsModel> incomings;
  final double width;
  const IncomingsGridView({
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenWidth * .4,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),

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
            borderRadius: BorderRadius.circular(20),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.center,
                    height: width * .1,
                    // width: width * .15,
                    decoration: BoxDecoration(
                      color: ColorManager.secondary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: FittedBox(
                      child: Text(
                        incomings[index].incomingDate.toPersian().toString(),
                        style: TextStyle(
                          color: ColorManager.onSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            '${incomings[index].boxes.toString().withPersianNumbers()} جعبه',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorManager.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'از ${incomingItemsBrand.personName}',
                            style: TextStyle(
                                color: ColorManager.onPrimaryContainer
                                    .withOpacity(.7)),
                          ),
                        ),
                      ],
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
