import 'package:flutter/material.dart';
import 'package:persian/persian.dart';

import '../../widgets/screens_style.dart';
import '../resources/routes_manager.dart';

class IncomingGoodsManagementScreen extends StatelessWidget {
  final String title;
  final int boxNumber;
  final DateTime dateTime;

  const IncomingGoodsManagementScreen({
    Key? key,
    required this.title,
    required this.boxNumber,
    required this.dateTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: title,
      description:
          'ورود ${boxNumber.toString().withPersianNumbers()} کارتن در تاریخ ${dateTime.toPersian()}',
      body: Container(),
      actionIcon: CircleAvatar(
        backgroundColor: Colors.black12,
        child: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.incomingGoodsManagementRoute);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )),
      ),
      bodyButton: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('ثبت کالا'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
