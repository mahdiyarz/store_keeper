import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/show_modal_bottom_button.dart';
import 'create_or_update_person_screen.dart';
import 'local_widgets/persons_grid_view.dart';

class PersonsManagementScreen extends StatelessWidget {
  const PersonsManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: 'مدیریت اشخاص',
      description: 'ثبت، اصلاح و یا حذف اشخاص',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: const ShowModalBottomButton(
        buttonTitle: 'ایجاد شخص جدید',
        buttonIcon: Icons.playlist_add_circle_rounded,
        showModalChildWidget: CreateOrUpdatePersonScreen(oldPerson: null),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          if (appState is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (appState is DisplayAppState) {
            return appState.personsList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: PersonsGridView(
                      personsList: appState.personsList,
                    ),
                  )
                : Column(
                    children: [
                      Image.asset(ImageAssets.personScreen),
                      const Text('شخص حقوقی ثبت کنم یا حقیقی؟'),
                    ],
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
