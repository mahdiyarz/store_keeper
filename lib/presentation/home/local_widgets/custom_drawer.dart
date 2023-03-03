import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

import '../../../widgets/custom_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * .1,
              vertical: width * .2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: ColorManager.primaryContainer,
              borderRadius: BorderRadius.circular(35),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 10,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: CircleAvatar(
                        backgroundColor: ColorManager.secondary,
                        maxRadius: 20,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: ColorManager.onSecondary.withOpacity(.6),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: width * .2,
                          ),
                          CustomListTile(
                            onTap: () {},
                            title: 'راهنمای تصویری',
                            titleIcon: Icons.video_collection,
                            leftIcon: Icons.arrow_forward_ios_rounded,
                          ),
                          CustomListTile(
                            onTap: () {},
                            title: 'بازیابی اطلاعات',
                            titleIcon: Icons.data_exploration_rounded,
                            leftIcon: Icons.arrow_forward_ios_rounded,
                          ),
                          CustomListTile(
                            onTap: () {},
                            title: 'پشتیبانی از اطلاعات',
                            titleIcon: Icons.backup_rounded,
                            leftIcon: Icons.arrow_forward_ios_rounded,
                          ),
                          CustomListTile(
                            onTap: () {},
                            title: 'اطلاعات بیشتر',
                            titleIcon: Icons.question_mark_rounded,
                            leftIcon: Icons.arrow_forward_ios_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Text(
                              'Designed and develope by Mahdiyar Arbabzi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: ColorManager.onPrimaryContainer
                                      .withOpacity(.6)),
                            ),
                            Text(
                              'm.arbabzi@gmail.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: ColorManager.onPrimaryContainer
                                      .withOpacity(.6)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
