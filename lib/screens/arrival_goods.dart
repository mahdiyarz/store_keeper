import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/arrival_goods_model.dart';
import '../widgets/screens_style.dart';
import '../providers/arrival_goods_provider.dart';

class ArrivalGoods extends StatelessWidget {
  static const routeName = '/arrival-goods';
  ArrivalGoods({Key? key}) : super(key: key);

  var boxNumberController = TextEditingController();
  var brandNameController = TextEditingController();

  void _showModalBottomSheet(BuildContext context, double width) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: width * 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      keyboardType: TextInputType.name,
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
                    TextFormField(
                      controller: brandNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'نام برند',
                        hintStyle: TextStyle(color: Colors.black26),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'نام برند را وارد نکردید!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Provider.of<ArrivalGoodsProvider>(context,
                                        listen: false)
                                    .insertData(ArrivalGoodsModel(
                                        brandId:
                                            int.parse(brandNameController.text),
                                        numOfBoxes:
                                            int.parse(boxNumberController.text),
                                        arrivalGoodsDate: DateTime.now()));
                              },
                              child: const Text('ثبت')),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('انصراف')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      screenTitle: 'ورودی های انبار',
      screenDescription: 'ثبت، اصلاح و تهیه گزارش ورودی های انبار',
      screenWidget: FutureBuilder(
        future: Provider.of<ArrivalGoodsProvider>(context, listen: false)
            .fetchData(),
        builder: (context, snapShots) =>
            snapShots.connectionState == ConnectionState.waiting
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
                              itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 99,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: Text(value
                                      .arrivalGoodsItems[index].arrivalGoodsDate
                                      .toString()),
                                  subtitle: Text(value
                                      .arrivalGoodsItems[index].arrivalGoodsId
                                      .toString()),
                                ),
                              ),
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
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('لیست جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
