import 'package:flutter/material.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../presentation/brands/create_or_update_brand_screen.dart';

class BrandsGridView extends StatelessWidget {
  final double screenWidth;
  final List<BrandsModel> brandsList;
  const BrandsGridView({
    Key? key,
    required this.screenWidth,
    required this.brandsList,
  }) : super(key: key);

  void _showModalBottomSheet(
    BuildContext context, {
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
          child: CreateOrUpdateBrandScreen(
            oldBrand: brandsModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //! to disable GridView's scrolling
      shrinkWrap: true, //! You won't see infinite size error
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenWidth * .3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: brandsList.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: ColorManager.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadow,
              blurRadius: 15,
              offset: const Offset(5, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  brandsList[index].name,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            subtitle: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                brandsList[index].latin,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            onTap: () {
              _showModalBottomSheet(
                context,
                brandsModel: brandsList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
