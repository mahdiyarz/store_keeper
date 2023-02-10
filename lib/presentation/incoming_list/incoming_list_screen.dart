import 'package:flutter/material.dart';
import 'package:store_keeper/bloc/bloc_exports.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/incoming_list_list_view.dart';
import '../../widgets/screens_style.dart';
import '../../widgets/show_modal_bottom_button.dart';
import '../resources/import_resources.dart';
import 'create_or_update_incoming_list_screen.dart';

class IncomingListScreen extends StatelessWidget {
  IncomingListScreen({Key? key}) : super(key: key);

  final TextEditingController boxNumberController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController brandIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScreensStyle(
      screenTitle: 'ورودی های انبار',
      screenDescription: 'ثبت، اصلاح و تهیه گزارش ورودی های انبار',
      mainButton: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
        iconColor: Colors.white,
      ),
      bottomWidget: ShowModalBottomButton(
        buttonTitle: 'ایجاد برند جدید',
        buttonIcon: Icons.playlist_add_circle_rounded,
        showModalChildWidget: CreateOrUpdateIncomingListScreen(
          boxNumberController: boxNumberController,
          brandNameController: brandNameController,
          brandIdController: brandIdController,
        ),
      ),
      screenWidget: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          if (appState is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (appState is DisplayAppState) {
            return appState.incomingList.isNotEmpty
                ? IncomingListListView(
                    width: width,
                    brandsList: appState.brandsList,
                    incomingList: appState.incomingList,
                  )
                :
                // TODO: Need more design for here
                const Text('NO DATA');
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
