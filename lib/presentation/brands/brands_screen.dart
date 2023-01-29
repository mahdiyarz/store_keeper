import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/widgets/screens_style.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreensStyle(
      screenTitle: 'مدیریت برندها',
      screenDescription: 'ثبت، اصلاح و یا حذف برند',
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
          // _showModalBottomSheet(context, width, null);
          // textController.text = '';
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('اضافه کردن برند جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      screenWidget: BlocConsumer<BrandsBloc, BrandsState>(
        listener: (context, state) {
          if (state is AddBrand) {
            log('state add brand');
          }
        },
        builder: (context, state) {
          final List<BrandsModel> brandsList = state.brandsList;
          return FutureBuilder(
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : Container(),
          );
        },
      ),
    );
  }
}
