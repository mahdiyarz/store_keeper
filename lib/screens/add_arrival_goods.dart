import 'package:flutter/material.dart';

import '../widgets/screens_style.dart';

class AddArrivalGoods extends StatelessWidget {
  static const routeName = '/add-arrival-goods';
  const AddArrivalGoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      screenTitle: 'ثبت ورودی انبار',
      screenDescription: 'لطفا تمامی قسمت های مربوطه را تکمیل کنید',
      screenWidget: Center(child: Text('data')),
      bottomWidget: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.save),
        label: const Text('ذخیره لیست'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
