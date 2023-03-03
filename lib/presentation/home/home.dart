import 'package:flutter/material.dart';

import 'local_widgets/control_panel.dart';
import 'local_widgets/custom_drawer.dart';
import 'local_widgets/introduce_container.dart';
import '../resources/import_resources.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  child: IntroduceContainer(),
                ),
                Positioned(
                  bottom: 25,
                  child: SizedBox(
                      width: width,
                      height: width,
                      child: Image.asset(ImageAssets.homeScreen)),
                ),
                const ControlPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
