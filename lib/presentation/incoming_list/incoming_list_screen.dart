import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/bloc/incoming_list_bloc/incoming_list_bloc.dart';

import '../../widgets/screens_style.dart';
import 'create_or_update_incoming_list_screen.dart';

class IncomingListScreen extends StatefulWidget {
  const IncomingListScreen({Key? key}) : super(key: key);

  @override
  State<IncomingListScreen> createState() => _IncomingListScreenState();
}

class _IncomingListScreenState extends State<IncomingListScreen> {
  final TextEditingController boxNumberController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController brandIdController = TextEditingController();

  @override
  void dispose() {
    boxNumberController.dispose();
    brandNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Provider.of<BrandsProvider>(context, listen: false).fetchData();
    context.read<BrandsBloc>().add(const FetchBrands());

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

      screenWidget: BlocBuilder<IncomingListBloc, IncomingListState>(
        builder: (context, appState) {
          if (appState is IncomingListInitial) {
            context.read<IncomingListBloc>().add(const FetchAllIncomingLists());
            final brandsList =
                context.read<BrandsBloc>().add(const FetchBrands());
          }
          if (appState is DisplayAllIncomingList) {
            return appState.allIncomingLists.isNotEmpty
                ? Container()
                : const Text('NO DATA');
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),

      //  FutureBuilder(
      //   future: Provider.of<ArrivalGoodsProvider>(context, listen: false)
      //       .fetchData(),
      //   builder: (context, snapShots) => snapShots.connectionState ==
      //           ConnectionState.waiting
      //       ? const Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : Consumer<ArrivalGoodsProvider>(
      //           builder: ((context, value, child) {
      //             return value.arrivalGoodsItems.isEmpty
      //                 ? child as Widget
      //                 : ListView.builder(
      //                     physics:
      //                         const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      //                     shrinkWrap:
      //                         true, //! You won't see infinite size error
      //                     itemBuilder: (context, index) {
      //                       final brands = Provider.of<BrandsProvider>(context,
      //                               listen: false)
      //                           .brandsItems;
      //                       final arrivalGoodsData =
      //                           Provider.of<ArrivalGoodsProvider>(context,
      //                                   listen: false)
      //                               .arrivalGoodsItems;
      //                       final arrivalGoodsBrand = brands.firstWhere((element) =>
      //                           element.brandId ==
      //                           arrivalGoodsData[index]
      //                               .brandId); //*This logic find brand of specific arrival goods
      //                       return Container(
      //                         padding: const EdgeInsets.symmetric(
      //                             vertical: 3, horizontal: 5),
      //                         margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      //                         decoration: BoxDecoration(
      //                           boxShadow: [
      //                             BoxShadow(
      //                               color: ColorManager.shadow,
      //                               blurRadius: 99,
      //                             ),
      //                           ],
      //                         ),
      //                         child: PhysicalModel(
      //                           color: ColorManager.white,
      //                           elevation: 5,
      //                           shadowColor:
      //                               const Color(0xff040039).withOpacity(.2),
      //                           borderRadius: const BorderRadius.only(
      //                             bottomLeft: Radius.circular(8),
      //                             bottomRight: Radius.circular(20),
      //                             topLeft: Radius.circular(8),
      //                             topRight: Radius.circular(20),
      //                           ),
      //                           child: InkWell(
      //                             onTap: () {
      //                               Navigator.of(context).pushNamed(
      //                                 '/arrival-goods-manage',
      //                                 arguments: IncomingGoodsManagementScreen(
      //                                   title: arrivalGoodsBrand.brandName,
      //                                   boxNumber: value
      //                                       .arrivalGoodsItems[index]
      //                                       .numOfBoxes,
      //                                   dateTime: value.arrivalGoodsItems[index]
      //                                       .arrivalGoodsDate,
      //                                 ),
      //                               );
      //                             },
      //                             child: Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Container(
      //                                   padding: const EdgeInsets.all(5),
      //                                   margin: const EdgeInsets.all(3),
      //                                   alignment: Alignment.center,
      //                                   height: width * .15,
      //                                   width: width * .15,
      //                                   decoration: BoxDecoration(
      //                                     color: Theme.of(context)
      //                                         .colorScheme
      //                                         .secondary
      //                                         .withOpacity(.3),
      //                                     borderRadius:
      //                                         BorderRadius.circular(20),
      //                                   ),
      //                                   child: FittedBox(
      //                                     child: Text(
      //                                       arrivalGoodsBrand.brandName,
      //                                       style: const TextStyle(
      //                                         color: Colors.black54,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 Expanded(
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         vertical: 5, horizontal: 8),
      //                                     child: Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         FittedBox(
      //                                           child: Text(
      //                                             'ورود ${value.arrivalGoodsItems[index].numOfBoxes.toString().withPersianNumbers()} جعبه به انبار',
      //                                             style: const TextStyle(
      //                                                 fontSize: 16),
      //                                           ),
      //                                         ),
      //                                         const SizedBox(height: 5),
      //                                         FittedBox(
      //                                           child: Text(
      //                                             'در تاریخ ${value.arrivalGoodsItems[index].arrivalGoodsDate.toPersian().toString()}',
      //                                             style: const TextStyle(
      //                                                 color: Colors.black45),
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       );
      //                     },
      //                     itemCount: value.arrivalGoodsItems.length,
      //                   );
      //           }),
      //           child: const Center(
      //             child: Text('هنوز هیچ لیست کالایی ثبت نشده است'),
      //           )),
      // ),
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
