import 'package:flutter/material.dart';
import 'package:store_keeper/models/import_models.dart';

import 'package:store_keeper/presentation/brands/create_or_update_brand_screen.dart';

class ShowBrandsDialogScreen extends StatelessWidget {
  final List<BrandsModel> brandsList;
  const ShowBrandsDialogScreen({
    Key? key,
    required this.brandsList,
  }) : super(key: key);

  void _editingBottomSheet({
    required BuildContext context,
    required BrandsModel brandsModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
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
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
      height: width * .8,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: brandsList.isEmpty
          ? const Center(
              child: Text(
                'هنوز برند جدید ثبت نکردی!',
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width * .3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: brandsList.length,
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
                      child: Text(brandsList[index].brandName,
                          style: const TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center),
                    ),
                    subtitle: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(brandsList[index].brandLatinName,
                          style: const TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center),
                    ),
                    onLongPress: () {
                      Navigator.of(context).pop();
                      _editingBottomSheet(
                          context: context, brandsModel: brandsList[index]);
                    },
                    onTap: () => Navigator.pop(context, [
                      brandsList[index].brandId,
                      brandsList[index].brandName,
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
