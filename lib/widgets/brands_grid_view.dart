import 'package:flutter/material.dart';
import 'package:store_keeper/models/brands_model.dart';

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
        maxCrossAxisExtent: screenWidth * .4,
        childAspectRatio: 1.1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 99,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(brandsList[index].brandName)),
            subtitle: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(brandsList[index].brandLatinName),
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
      itemCount: brandsList.length,
    );
  }
}
