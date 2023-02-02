import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/models/brands_model.dart';

class AddBrandScreen extends StatelessWidget {
  const AddBrandScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameKey = GlobalKey<FormState>();
    final latinNameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController latinNameController = TextEditingController();

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
                ? const Text(
                    'لطفا نام برند مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const Text(
                    'لطفا نام برند را ویرایش کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
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
                label: Text('نام برند'),
                border: OutlineInputBorder(),
                hintText: 'به فارسی تایپ کنید...',
                hintStyle: TextStyle(color: Colors.black26),
              ),
              validator: (value) {
                if (value == null) 'نام برند را وارد نکردید!';
                return null;
              },
            ),
            const SizedBox(height: 25),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                key: latinNameKey,
                textAlign: TextAlign.left,
                controller: latinNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Brand\'s Name'),
                  hintText: 'Type in English...',
                  hintStyle: TextStyle(color: Colors.black26),
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
                            brandName: nameController.text,
                            brandLatinName: latinNameController.text,
                          );
                          Navigator.of(context).pop();
                          context
                              .read<BrandsBloc>()
                              .add(AddBrand(brand: brand));
                          context.read<BrandsBloc>().add(const FetchBrands());
                          nameController.clear();
                          latinNameController.clear();
                        } else if (nameController.value.text.isEmpty) {
                          // TODO: implement validation
                          return;
                        } else if (latinNameController.value.text.isEmpty) {
                          // TODO: implement validation
                          return;
                        }

                        // if (brandsModel != null) {
                        //   final BrandsModel updateBrand = BrandsModel(
                        //     brandId: brandsModel.brandId,
                        //     brandName: textController.text,
                        //   );
                        //   Provider.of<BrandsProvider>(context,
                        //           listen: false)
                        //       .updateData(updateBrand);
                        // } else {
                        //   Provider.of<BrandsProvider>(context,
                        //           listen: false)
                        //       .insertData(BrandsModel(
                        //           brandName: textController.text));
                        // }
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
    );
  }
}
