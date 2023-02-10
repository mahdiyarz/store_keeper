import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';

import '../../widgets/screens_style.dart';
import '../resources/import_resources.dart';
import 'create_or_update_incoming_list_screen.dart';

class IncomingListScreen extends StatelessWidget {
  IncomingListScreen({Key? key}) : super(key: key);

  final TextEditingController boxNumberController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController brandIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      screenTitle: 'ورودی های انبار',
      screenDescription: 'ثبت، اصلاح و تهیه گزارش ورودی های انبار',
      mainButton: CircleAvatar(
        backgroundColor: Colors.black12,
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )),
      ),
      bottomWidget: ElevatedButton.icon(
        onPressed: () {
          _showModalBottomSheet(context, width);
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('لیست جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      screenWidget: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          if (appState is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (appState is DisplayAppState) {
            return appState.incomingList.isNotEmpty
                ? ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
                    shrinkWrap: true, //! You won't see infinite size error
                    itemBuilder: (context, index) {
                      final brandsList = appState.brandsList;

                      final incomingItemsBrand = brandsList.firstWhere((element) =>
                          element.brandId ==
                          appState.incomingList[index]
                              .brandId); //*This logic find brand of specific arrival goods

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            'ورود ${appState.incomingList[index].numOfBoxes.toString().withPersianNumbers()} جعبه به انبار',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        FittedBox(
                                          child: Text(
                                            'در تاریخ ${appState.incomingList[index].incomingListDate.toPersian().toString()}',
                                            style: const TextStyle(
                                                color: Colors.black45),
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
                    itemCount: appState.incomingList.length,
                  )
                :
                // TODO: Need more design for here
                const Text('NO DATA');
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, double width) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CreateOrUpdateIncomingListScreen(
                boxNumberController: boxNumberController,
                brandNameController: brandNameController,
                brandIdController: brandIdController,
              ),
            ),
          );
        });
  }
}
