import 'package:flutter/material.dart';
import 'package:store_keeper/models/warehouses_model.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

class CreateOrUpdateWarehouseScreen extends StatelessWidget {
  final WarehousesModel? oldWarehouse;
  const CreateOrUpdateWarehouseScreen({
    Key? key,
    required this.oldWarehouse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();

    if (oldWarehouse != null) {
      if (oldWarehouse!.warehouseName.isNotEmpty) {
        nameController.text = oldWarehouse!.warehouseName;
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
                    'لطفا نام انبار مورد نظر خود را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorManager.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    'لطفا نام انبار را ویرایش کنید و دکمه ثبت را بزنید...',
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
                  'نام انبار',
                ),
                border: OutlineInputBorder(),
                hintText: 'انبار اصلی، فرعی، ضایعات...',
              ),
              validator: (value) {
                if (value == null) 'نام انبارتو وارد نکردی!';
                return null;
              },
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (nameController.value.text.isNotEmpty) {
                          final WarehousesModel warehouse = WarehousesModel(
                            warehouseName: nameController.text,
                          );
                          Navigator.of(context).pop();

                          // oldWarehouse != null
                          //     ?
                          //     // context.read<AppBloc>().add(
                          //     //       EditPerson(
                          //     //         oldPerson: oldPerson!,
                          //     //         newPerson: PersonsModel(
                          //     //             personId: oldPerson!.personId,
                          //     //             personName: nameController.text,
                          //     //             personDescription:
                          //     //                 descriptionController.text),
                          //     //       ),
                          //     //     )
                          //     : context
                          //         .read<AppBloc>()
                          //         .add(AddPerson(person: person));
                          nameController.clear();
                        } else if (nameController.value.text.isEmpty) {
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
                if (oldWarehouse != null) const SizedBox(width: 5),
                if (oldWarehouse != null)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        nameController.clear();
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
