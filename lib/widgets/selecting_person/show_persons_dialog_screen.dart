import 'package:flutter/material.dart';
import 'package:store_keeper/models/import_models.dart';
import 'package:store_keeper/presentation/persons/create_or_update_person_screen.dart';

class ShowPersonsDialogScreen extends StatelessWidget {
  final List<PersonsModel> personsList;

  const ShowPersonsDialogScreen({
    Key? key,
    required this.personsList,
  }) : super(key: key);

  void _editingBottomSheet({
    required BuildContext context,
    required PersonsModel personsModel,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CreateOrUpdatePersonScreen(
              oldPerson: personsModel,
            )),
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
      child: personsList.isEmpty
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
              itemCount: personsList.length,
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
                      child: Text(personsList[index].name,
                          style: const TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center),
                    ),
                    onLongPress: () {
                      Navigator.of(context).pop();
                      _editingBottomSheet(
                        context: context,
                        personsModel: personsList[index],
                      );
                    },
                    onTap: () => Navigator.pop(context, [
                      personsList[index].id,
                      personsList[index].name,
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
