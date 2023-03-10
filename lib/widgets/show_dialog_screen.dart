import 'package:flutter/material.dart';
import 'package:store_keeper/models/brands_model.dart';

import 'package:store_keeper/models/persons_model.dart';
import 'package:store_keeper/presentation/brands/create_or_update_brand_screen.dart';
import 'package:store_keeper/presentation/persons/create_or_update_person_screen.dart';

class ShowDialogScreen extends StatelessWidget {
  final double width;
  final List<PersonsModel>? personsList;
  final List<BrandsModel>? brandsList;
  final bool isAddingNewPerson;
  const ShowDialogScreen({
    Key? key,
    required this.width,
    required this.personsList,
    required this.brandsList,
    required this.isAddingNewPerson,
  }) : super(key: key);

  void _editingBottomSheet({
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
    return Container(
      width: width * .5,
      height: width * .8,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: isAddingNewPerson
          ? personsList!.isEmpty
              ? const Center(
                  child: Text(
                    'اشخاص ثبت شده ندارید!',
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
                  itemCount: personsList!.length,
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
                          child: Text(personsList![index].personName,
                              style: const TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center),
                        ),
                        onLongPress: () {
                          Navigator.of(context).pop();
                          _editingBottomSheet(
                            context: context,
                            isAddingPerson: isAddingNewPerson,
                            personsModel: personsList![index],
                            brandsModel: null,
                          );
                        },
                        onTap: () => Navigator.pop(context, [
                          personsList![index].personId,
                          personsList![index].personName,
                        ]),
                      ),
                    ),
                  ),
                )
          : brandsList!.isEmpty
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
                  itemCount: brandsList!.length,
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
                          child: Text(brandsList![index].brandName,
                              style: const TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center),
                        ),
                        subtitle: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(brandsList![index].brandLatinName,
                              style: const TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center),
                        ),
                        onLongPress: () {
                          Navigator.of(context).pop();
                          _editingBottomSheet(
                              context: context,
                              isAddingPerson: isAddingNewPerson,
                              personsModel: null,
                              brandsModel: brandsList![index]);
                        },
                        onTap: () => Navigator.pop(context, [
                          brandsList![index].brandId,
                          brandsList![index].brandName,
                        ]),
                      ),
                    ),
                  ),
                ),
    );
  }
}
