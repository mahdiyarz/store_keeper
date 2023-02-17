import 'package:flutter/material.dart';

import '../../widgets/control_panel.dart';
import '../../widgets/introduce_container.dart';
import '../resources/import_resources.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    child: IntroduceContainer(),
                  ),
                  ControlPanel(),
                ],
              ),
              Image.asset(ImageAssets.homeScreen),
              SizedBox(
                height: width * .001,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
