import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/models/brands_model.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import 'create_or_update_brand_screen.dart';

class BrandsManagementScreen extends StatelessWidget {
  const BrandsManagementScreen({
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet(BuildContext context, {BrandsModel? brandsModel}) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdateBrandScreen(oldBrand: brandsModel),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
          _showModalBottomSheet(context);
        },
        icon: const Icon(Icons.post_add_rounded),
        label: const Text('اضافه کردن برند جدید'),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      screenWidget: BlocBuilder<BrandsBloc, BrandsState>(
        builder: (context, appState) {
          if (appState is BrandsStateInitial) {
            context.read<BrandsBloc>().add(const FetchBrands());
          }
          if (appState is DisplayBrandsState) {
            return appState.brandsList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
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
                                child:
                                    Text(appState.brandsList[index].brandName)),
                            subtitle: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                  appState.brandsList[index].brandLatinName),
                            ),
                            onTap: () {
                              _showModalBottomSheet(
                                context,
                                brandsModel: appState.brandsList[index],
                              );
                            },
                          ),
                        ),
                      ),
                      itemCount: appState.brandsList.length,
                    ),
                  )
                :
                // TODO: Need more design for here
                const Center(
                    child: Text('هنوز هیچ برندی ثبت نشده!'),
                  );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
