import 'package:flutter/material.dart';

import '../models/import_models.dart';
import '../models/persons_model.dart';
import '../presentation/brands/create_or_update_brand_screen.dart';
import '../presentation/persons/create_or_update_person_screen.dart';

class ShowDialogButton extends StatelessWidget {
  final bool isAddingNewPerson;
  const ShowDialogButton({
    required this.isAddingNewPerson,
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet({
    required BuildContext context,
    required bool isAddingPerson,
    PersonsModel? personsModel,
    BrandsModel? brandsModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: isAddingPerson
              ? CreateOrUpdatePersonScreen(
                  oldPerson: personsModel,
                )
              : CreateOrUpdateBrandScreen(
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
        _showModalBottomSheet(
          context: context,
          isAddingPerson: isAddingNewPerson,
          brandsModel: null,
          personsModel: null,
        );
      },
      icon: const Icon(Icons.edit_note_rounded, size: 18),
      label: isAddingNewPerson
          ? const Text('ایجاد شخص جدید')
          : const Text('ایجاد برند جدید'),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
