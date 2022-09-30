import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../providers/arrival_goods_provider.dart';

class ArrivalGoods extends StatelessWidget {
  static const routeName = '/arrival-goods';
  const ArrivalGoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              itemBuilder: (context, index) => Text(value
                                  .arrivalGoodsItems[index].arrivalGoodsDate
                                  .toString()),
                              itemCount: value.arrivalGoodsItems.length,
                            );
                    }),
                    child: const Center(
                      child: Text('هنوز هیچ لیست کالایی ثبت نشده است'),
                    )),
      ),
      bottomWidget: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed('add-arrival-goods');
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
