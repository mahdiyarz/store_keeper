import 'package:flutter/material.dart';
import 'package:store_keeper/models/persons_model.dart';
import 'package:store_keeper/presentation/persons/create_or_update_person_screen.dart';

import '../../resources/import_resources.dart';

class PersonsGridView extends StatelessWidget {
  final List<PersonsModel> personsList;
  const PersonsGridView({
    required this.personsList,
    Key? key,
  }) : super(key: key);

  void _showModalBottomSheet(
    BuildContext context, {
    PersonsModel? personsModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateOrUpdatePersonScreen(
            oldPerson: personsModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
      itemCount: personsList.length,
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
                  personsList[index].personName,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            onTap: () {
              _showModalBottomSheet(
                context,
                personsModel: personsList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
