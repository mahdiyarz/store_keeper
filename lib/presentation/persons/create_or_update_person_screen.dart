import 'package:flutter/material.dart';
import 'package:store_keeper/models/persons_model.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../bloc/bloc_exports.dart';

class CreateOrUpdatePersonScreen extends StatelessWidget {
  final PersonsModel? oldPerson;
  const CreateOrUpdatePersonScreen({
    Key? key,
    required this.oldPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    if (oldPerson != null) {
      if (oldPerson!.name.isNotEmpty) {
        nameController.text = oldPerson!.name;
      }
      if (oldPerson!.description!.isNotEmpty) {
        descriptionController.text = oldPerson!.description!;
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
                    'لطفا نام شخص مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorManager.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    'لطفا نام شخص را ویرایش کنید و دکمه ثبت را بزنید...',
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
                  'نام',
                ),
                border: OutlineInputBorder(),
                hintText: 'شخص حقیقی / شخص حقوقی...',
              ),
              validator: (value) {
                if (value == null) 'نام شخص را وارد نکردی!';
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  'توضیحات',
                ),
                hintText: 'خیلی خلاصه ش کن...',
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (nameController.value.text.isNotEmpty) {
                          final PersonsModel person = PersonsModel(
                            name: nameController.text,
                            description: descriptionController.text,
                          );
                          Navigator.of(context).pop();

                          oldPerson != null
                              ? context.read<AppBloc>().add(
                                    EditPerson(
                                      oldPerson: oldPerson!,
                                      newPerson: PersonsModel(
                                          id: oldPerson!.id,
                                          name: nameController.text,
                                          description:
                                              descriptionController.text),
                                    ),
                                  )
                              : context
                                  .read<AppBloc>()
                                  .add(AddPerson(person: person));
                          nameController.clear();
                          descriptionController.clear();
                        } else if (nameController.value.text.isEmpty) {
                          // TODO: implement validation
                          return;
                        } else if (descriptionController.value.text.isEmpty) {
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
                if (oldPerson != null) const SizedBox(width: 5),
                if (oldPerson != null)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        nameController.clear();
                        descriptionController.clear();
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
