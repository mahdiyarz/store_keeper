import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';

import '../../widgets/CircleButton.dart';
import 'local_widgets/incomings_grid_view.dart';
import '../../widgets/screens_style.dart';
import '../../widgets/show_modal_bottom_button.dart';
import '../resources/import_resources.dart';
import 'create_or_update_incoming_list_screen.dart';

class IncomingsScreen extends StatefulWidget {
  const IncomingsScreen({Key? key}) : super(key: key);

  @override
  State<IncomingsScreen> createState() => _IncomingsScreenState();
}

class _IncomingsScreenState extends State<IncomingsScreen> {
  bool isInfoButtonToggle = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: 'ورودی های انبار',
      description: 'ثبت، اصلاح و تهیه گزارش ورودی انبار',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: Row(
        children: [
          Expanded(
            child: ShowModalBottomButton(
              buttonTitle: 'ثبت ورود به انبار',
              buttonIcon: Icons.playlist_add_circle_rounded,
              showModalChildWidget: CreateOrUpdateIncomingListScreen(
                personsList: null,
                oldIncomingList: null,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: ColorManager.error.withOpacity(.7),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isInfoButtonToggle = !isInfoButtonToggle;
                  });
                },
                icon: Icon(
                  Icons.question_mark_rounded,
                  color: ColorManager.onError,
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isInfoButtonToggle,
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(
                bottom: 5,
                left: 23,
                right: 23,
              ),
              decoration: BoxDecoration(
                color: ColorManager.error.withOpacity(.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: ColorManager.onError,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          'ایجاد لیست: پایین صفحه روی دکمه ثبت ورودی به انبار کلیک کن.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorManager.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: ColorManager.onError,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          'ویرایش/حذف: هر کدوم از لیست ها که میخواین روش عملیات ویژه انجام بدید، دوبار کلیک کنید.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorManager.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              if (appState is AppStateInitial) {
                context.read<AppBloc>().add(const FetchEvent());
              }
              if (appState is DisplayAppState) {
                return appState.incomingList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: IncomingsGridView(
                          width: width,
                          personsList: appState.personsList,
                          incomings: appState.incomingList,
                        ),
                      )
                    : Column(
                        children: [
                          Image.asset(ImageAssets.incomingListScreen),
                          const Text('هیچ ورودیی نداشتیم تاحالا'),
                        ],
                      );
              }
              return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}
