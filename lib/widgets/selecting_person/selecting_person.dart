import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_keeper/widgets/selecting_person/show_persons_dialog_screen.dart';

import 'package:store_keeper/widgets/show_dialog_button.dart';

import '../../bloc/bloc_exports.dart';
import '../../models/persons_model.dart';
import '../../presentation/resources/import_resources.dart';

class SelectingPerson extends StatelessWidget {
  final DisplayAppState goodState;
  final TextEditingController personNameController;
  final TextEditingController personIdController;

  const SelectingPerson({
    Key? key,
    required this.goodState,
    required this.personNameController,
    required this.personIdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: ColorManager.primaryContainer,
      ),
      onPressed: () {
        showPersonsDialog(context, goodState, width).then((returnValue) {
          log('value is $returnValue');

          if (returnValue != null) {
            personNameController.text = returnValue[1];
            final List<PersonsModel> cashedPersons = goodState.personsList;
            final PersonsModel chosenPerson = cashedPersons.firstWhere(
                (element) => element.personName == personNameController.text);
            personIdController.text = chosenPerson.personId.toString();
          }
        });
      },
      child: Text(
        'کی فرستاده؟',
        style: TextStyle(
          color: ColorManager.onPrimaryContainer,
        ),
      ),
    );
  }

  Future<dynamic> showPersonsDialog(
      BuildContext context, DisplayAppState appState, double width) {
    return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: appState.personsList.isNotEmpty
                ? const Text(
                    'بگو از کجا اومده',
                    textAlign: TextAlign.center,
                  )
                : null,
            children: [
              ShowPersonsDialogScreen(
                personsList: appState.personsList,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: ShowDialogButton(
                  isAddingNewPerson: true,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
