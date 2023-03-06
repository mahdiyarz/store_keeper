import 'package:flutter/material.dart';

import 'package:store_keeper/bloc/bloc_exports.dart';
import 'package:store_keeper/presentation/resources/import_resources.dart';
import 'package:store_keeper/presentation/warehouse/local_widgets/warehouse_grid_view.dart';
import 'package:store_keeper/widgets/screens_style.dart';

import '../../widgets/CircleButton.dart';
import '../../widgets/show_modal_bottom_button.dart';
import 'local_widgets/create_or_update_warehouse_screen.dart';

class WarehousesManagementScreen extends StatelessWidget {
  const WarehousesManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ScreensStyle(
      title: 'مدیریت انبارها',
      description: 'ایجاد، اصلاح و یا حذف انبار',
      actionIcon: const CircleButton(
        iconNamedRoute: Routes.homeRoute,
        iconShape: Icons.arrow_forward,
      ),
      bodyButton: const ShowModalBottomButton(
        buttonTitle: 'ایجاد انبار جدید',
        buttonIcon: Icons.playlist_add_circle_rounded,
        showModalChildWidget: CreateOrUpdateWarehouseScreen(oldWarehouse: null),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          if (appState is AppStateInitial) {
            context.read<AppBloc>().add(const FetchEvent());
          }
          if (appState is DisplayAppState) {
            return appState.warehousesList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: WarehousesGridView(
                      warehousesList: appState.warehousesList,
                    ),
                  )
                : Column(
                    children: [
                      Image.asset(ImageAssets.warehouseScreen),
                      const Text('چند تا انبار نیاز دارم؟'),
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
