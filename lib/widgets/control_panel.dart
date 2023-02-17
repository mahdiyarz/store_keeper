import 'package:flutter/material.dart';

import '../presentation/resources/import_resources.dart';
import 'home_button.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(
            height: width * .2,
          ),
          Center(
              child: Text(
            'انبار جیبی',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: FontSize.s20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 65,
                    color: Theme.of(context).colorScheme.shadow,
                  )
                ]),
          )),
          Center(
              child: Text(
            'مدیریت انبارت، توی جیبته',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: FontSize.s14,
            ),
          )),
          const SizedBox(
            height: 35,
          ),
          Container(
            width: width,
            height: width * .35,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                HomeButton(
                  title: 'ورود کالا',
                  icon: Icons.archive_rounded,
                  routeName: Routes.incomingListsRoute,
                ),
                SizedBox(
                  width: 5,
                ),
                HomeButton(
                  title: 'انبار گردانی',
                  icon: Icons.app_registration_rounded,
                  routeName: Routes.homeRoute,
                ),
                SizedBox(
                  width: 5,
                ),
                HomeButton(
                  title: 'بروزرسانی',
                  icon: Icons.refresh_rounded,
                  routeName: Routes.homeRoute,
                ),
                SizedBox(
                  width: 5,
                ),
                HomeButton(
                  title: 'راه اندازی',
                  icon: Icons.settings_outlined,
                  routeName: Routes.brandsRoute,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
