import 'package:flutter/material.dart';

import '../models/import_models.dart';
import '../presentation/brands/create_or_update_brand_screen.dart';

class ShowDialogButton extends StatelessWidget {
  const ShowDialogButton({
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet(BuildContext context, {BrandsModel? brandsModel}) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 20,
      ),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateBrandScreen(
            oldBrand: brandsModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
        _showModalBottomSheet(context);
      },
      icon: const Icon(Icons.edit_note_rounded, size: 18),
      label: const Text('ایجاد برند جدید'),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
