import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/models/persons_model.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../models/import_models.dart';
import '../../widgets/selecting_person.dart';

class CreateOrUpdateIncomingListScreen extends StatelessWidget {
  final IncomingsModel? oldIncomingList;
  final List<PersonsModel>? personsList;
  CreateOrUpdateIncomingListScreen({
    required this.oldIncomingList,
    required this.personsList,
    Key? key,
  }) : super(key: key);

  TextEditingController boxNumberController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController personIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (oldIncomingList != null) {
      boxNumberController.text = oldIncomingList!.boxes.toString();
      final String personName = personsList!
          .firstWhere(
              (element) => element.personId == oldIncomingList!.personId)
          .personName;
      personNameController.text = personName;
      personIdController.text = oldIncomingList!.personId.toString();
    }

    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      if (appState is AppStateInitial) {
        context.read<AppBloc>().add(const FetchEvent());
      }
      if (appState is DisplayAppState) {
        return Form(
          key: _formKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'لطفا تعداد جعبه های ورودی و فرستنده محصولات را وارد کنید و دکمه ثبت را بزنید...',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorManager.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: boxNumberController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: ColorManager.error.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 0),
                            color: ColorManager.onError,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      label: const Text('تعداد جعبه'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'تعداد جعبه های ورودی اجباریه!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: personNameController,
                          readOnly: true,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: ColorManager.error.withOpacity(.7),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 0),
                                  color: ColorManager.onError,
                                  blurRadius: 30,
                                )
                              ],
                            ),
                            hintText: 'شخص فرستنده کالا رو مشخص کن...',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'اصل کار همینه، با دقت انتخاب کن...';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SelectingPerson(
                        goodState: appState,
                        personNameController: personNameController,
                        personIdController: personIdController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (personNameController.text.isNotEmpty &&
                                  boxNumberController.text.isNotEmpty &&
                                  personIdController.text.isNotEmpty) {
                                final snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  content: oldIncomingList != null
                                      ? const Text(
                                          'به خوبی ویرایشش کردی',
                                          textAlign: TextAlign.center,
                                        )
                                      : const Text(
                                          'یکی دیگه به لیست اضافه شد',
                                          textAlign: TextAlign.center,
                                        ),
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                );
                                oldIncomingList != null
                                    ? context.read<AppBloc>().add(
                                          EditIncomingList(
                                            oldIncomingListId:
                                                oldIncomingList!.incomingId!,
                                            newIncomingListItem: IncomingsModel(
                                                personId: int.parse(
                                                    personIdController.text),
                                                boxes: int.parse(
                                                    boxNumberController.text),
                                                incomingDate: oldIncomingList!
                                                    .incomingDate),
                                          ),
                                        )
                                    : context.read<AppBloc>().add(
                                          AddIncomingList(
                                            addIncomingListItem: IncomingsModel(
                                              personId: int.parse(
                                                personIdController.text,
                                              ),
                                              boxes: int.parse(
                                                boxNumberController.text,
                                              ),
                                              incomingDate: DateTime.now(),
                                            ),
                                          ),
                                        );
                                Navigator.of(context).pop();
                                clearTextControllers();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text('ثبت'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('انصراف'),
                      ),
                      if (oldIncomingList != null) const SizedBox(width: 5),
                      if (oldIncomingList != null)
                        ElevatedButton(
                          onPressed: () {
                            context.read<AppBloc>().add(
                                  DeleteIncomingList(
                                      deleteIncomingListItem: oldIncomingList!),
                                );
                            Navigator.of(context).pop();
                            clearTextControllers();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              dismissDirection: DismissDirection.up,
                              content: Text(
                                'این ورودی از لیستت حذف شد',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(
                                seconds: 2,
                              ),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.error,
                            foregroundColor: ColorManager.onError,
                          ),
                          child: const Text('حذف'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const Text('data');
    });
  }

  // Future<dynamic> showBrandsDialog(
  //     BuildContext context, DisplayAppState appState, double width) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: SimpleDialog(
  //           title: appState.brandsList.isNotEmpty
  //               ? const Text('برند خود را انتخاب کنید',
  //                   textAlign: TextAlign.center)
  //               : null,
  //           children: [
  //             ShowDialogScreen(
  //               width: width,
  //               personsList: appState.personsList,
  //               brandsList: null,
  //               isAddingNewPerson: true,
  //             ),
  //             const Padding(
  //               padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
  //               child: ShowDialogButton(),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void clearTextControllers() {
    boxNumberController.clear();
    personNameController.clear();
    personIdController.clear();
  }
}
