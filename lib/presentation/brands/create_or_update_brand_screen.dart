import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '/bloc/bloc_exports.dart';
import '/models/import_models.dart';

class CreateOrUpdateBrandScreen extends StatelessWidget {
  final BrandsModel? oldBrand;
  const CreateOrUpdateBrandScreen({
    Key? key,
    required this.oldBrand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameKey = GlobalKey<FormState>();
    final latinNameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController latinNameController = TextEditingController();

    if (oldBrand != null) {
      if (oldBrand!.name.isNotEmpty) {
        nameController.text = oldBrand!.name;
      }
      if (oldBrand!.latin.isNotEmpty) {
        latinNameController.text = oldBrand!.latin;
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            nameController.text.isEmpty
                ? Text(
                    'لطفا نام برند مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorManager.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    'لطفا نام برند را ویرایش کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorManager.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              key: nameKey,
              autofocus: true,
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text(
                  'نام برند',
                ),
                border: OutlineInputBorder(),
                hintText: 'به فارسی تایپ کنید...',
              ),
              validator: (value) {
                if (value == null) 'نام برند را وارد نکردید!';
                return null;
              },
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                key: latinNameKey,
                textAlign: TextAlign.left,
                controller: latinNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Brand\'s Name',
                  ),
                  hintText: 'Type in English...',
                ),
                validator: (value) {
                  if (value == null) 'نام لاتین برند را وارد نکردید!';
                  return null;
                },
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (nameController.value.text.isNotEmpty &&
                            latinNameController.value.text.isNotEmpty) {
                          final BrandsModel brand = BrandsModel(
                            name: nameController.text,
                            latin: latinNameController.text,
                          );
                          Navigator.of(context).pop();
                          oldBrand != null
                              ? context.read<AppBloc>().add(EditBrand(
                                    oldBrand: oldBrand!,
                                    newBrand: brand,
                                  ))
                              : context
                                  .read<AppBloc>()
                                  .add(AddBrand(brand: brand));
                          nameController.clear();
                          latinNameController.clear();
                        } else if (nameController.value.text.isEmpty) {
                          // TODO: implement validation
                          return;
                        } else if (latinNameController.value.text.isEmpty) {
                          // TODO: implement validation
                          return;
                        }
                      },
                      child: const Text('ثبت')),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('انصراف')),
                if (oldBrand != null) const SizedBox(width: 5),
                if (oldBrand != null)
                  ElevatedButton(
                      onPressed: () {
                        context.read<AppBloc>().add(
                              DeleteBrand(
                                brand: oldBrand!,
                              ),
                            );
                        Navigator.of(context).pop();
                        nameController.clear();
                        latinNameController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.error,
                        foregroundColor: ColorManager.onError,
                      ),
                      child: const Text('حذف')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
