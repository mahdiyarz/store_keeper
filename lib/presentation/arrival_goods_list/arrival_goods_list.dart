import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persian/persian.dart';

import '../import_presentation.dart';
import '../resources/color_manager.dart';
import '../../models/import_models.dart';
import '../../widgets/screens_style.dart';
import '../../providers/import_providers.dart';

class ArrivalGoodsList extends StatefulWidget {
  static const routeName = '/arrival-goods-list';
  const ArrivalGoodsList({Key? key}) : super(key: key);

  @override
  State<ArrivalGoodsList> createState() => _ArrivalGoodsListState();
}

class _ArrivalGoodsListState extends State<ArrivalGoodsList> {
  var boxNumberController = TextEditingController();
  var brandNameController = TextEditingController();

  @override
  void dispose() {
    boxNumberController.dispose();
    brandNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Provider.of<BrandsProvider>(context, listen: false).fetchData();

    return ScreensStyle(
      screenTitle: 'ورودی های انبار',
      screenDescription: 'ثبت، اصلاح و تهیه گزارش ورودی های انبار',
      screenWidget: FutureBuilder(
        future: Provider.of<ArrivalGoodsProvider>(context, listen: false)
            .fetchData(),
        builder: (context, snapShots) => snapShots.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ArrivalGoodsProvider>(
                builder: ((context, value, child) {
                  return value.arrivalGoodsItems.isEmpty
                      ? child as Widget
                      : ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
                          shrinkWrap:
                              true, //! You won't see infinite size error
                          itemBuilder: (context, index) {
                            final brands = Provider.of<BrandsProvider>(context,
                                    listen: false)
                                .brandsItems;
                            final arrivalGoodsData =
                                Provider.of<ArrivalGoodsProvider>(context,
                                        listen: false)
                                    .arrivalGoodsItems;
                            final arrivalGoodsBrand = brands.firstWhere((element) =>
                                element.brandId ==
                                arrivalGoodsData[index]
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
                                shadowColor:
                                    const Color(0xff040039).withOpacity(.2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(20),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/arrival-goods-manage',
                                      arguments: ArrivalGoodsManagement(
                                        title: arrivalGoodsBrand.brandName,
                                        boxNumber: value
                                            .arrivalGoodsItems[index]
                                            .numOfBoxes,
                                        dateTime: value.arrivalGoodsItems[index]
                                            .arrivalGoodsDate,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            arrivalGoodsBrand.brandName,
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
                                                  'ورود ${value.arrivalGoodsItems[index].numOfBoxes.toString().withPersianNumbers()} جعبه به انبار',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              FittedBox(
                                                child: Text(
                                                  'در تاریخ ${value.arrivalGoodsItems[index].arrivalGoodsDate.toPersian().toString()}',
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
                          itemCount: value.arrivalGoodsItems.length,
                        );
                }),
                child: const Center(
                  child: Text('هنوز هیچ لیست کالایی ثبت نشده است'),
                )),
      ),
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
          brandNameController.text = '';
          boxNumberController.text = '';
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('لیست جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, double width) {
    var showBrandName;
    var brandPostBack;
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListView(
                children: [
                  const Text(
                    'لطفا تعداد جعبه های ورودی و برند محصولات را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    controller: boxNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'تعداد جعبه',
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'تعداد جعبه های ورودی را وارد نکردید!';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.3),
                    ),
                    onPressed: () {
                      List<BrandsModel> brands =
                          Provider.of<BrandsProvider>(context, listen: false)
                              .brandsItems;
                      showDialog(
                        context: context,
                        builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: SimpleDialog(
                            title: const Text('برند خود را انتخاب کنید',
                                textAlign: TextAlign.center),
                            children: [
                              Container(
                                width: width * .5,
                                height: width * .8,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: width * .3,
                                    childAspectRatio: 1.2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: brands.length,
                                  itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(.3)),
                                    child: Center(
                                      child: ListTile(
                                        title: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(brands[index].brandName,
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                              textAlign: TextAlign.center),
                                        ),
                                        onTap: () => Navigator.pop(context, [
                                          brands[index].brandId,
                                          brands[index].brandName,
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/brands');
                                  },
                                  icon: const Icon(Icons.dangerous, size: 18),
                                  label: const Text('برند مورد نظر موجود نیست'),
                                  style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ).then((returnValue) {
                        if (returnValue != null) {
                          brandPostBack = returnValue;
                          brandNameController.text = brandPostBack[0]
                              .toString(); //? Pass brand id to out controller
                          setState(() {
                            showBrandName =
                                returnValue; //? To show brand name in real time on button label
                          });
                        }
                      });
                    },
                    child: showBrandName == null
                        ? const Text(
                            'هنوز برند انتخاب نشده',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        : Text(
                            showBrandName[1],
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: brandNameController.text.isNotEmpty &&
                                  boxNumberController.text.isNotEmpty
                              ? () {
                                  Navigator.of(context).pop();

                                  Provider.of<ArrivalGoodsProvider>(context,
                                          listen: false)
                                      .insertData(ArrivalGoodsModel(
                                          brandId: int.parse(
                                              brandNameController.text),
                                          numOfBoxes: int.parse(
                                              boxNumberController.text),
                                          arrivalGoodsDate: DateTime.now()));
                                }
                              : null,
                          child: const Text('ثبت'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('انصراف'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
