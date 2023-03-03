import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/brands_grid_view.dart';
import '../../widgets/show_modal_bottom_button.dart';
import 'create_or_update_person_screen.dart';

class PersonsManagementScreen extends StatelessWidget {
  const PersonsManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                    child: BrandsGridView(
                      screenWidth: screenWidth,
                      brandsList: appState.brandsList,
                    ),
                  )
                : Column(
                    children: [
                      Image.asset(ImageAssets.brandsScreen),
                      const Text('هنوز هیچی ثبت نشده!'),
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
