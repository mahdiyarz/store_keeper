import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/import_resources.dart';
import 'animated_subset.dart';
import 'close_app_button.dart';
import 'introduction.dart';
import 'menu_button.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel>
    with TickerProviderStateMixin {
  late AnimationController _animationButton1Controller;
  late AnimationController _animationButton2Controller;
  late AnimationController _animationButton3Controller;
  bool isTappedButton1 = false;
  bool isTappedButton2 = false;
  bool isTappedButton3 = false;

  @override
  void initState() {
    _animationButton1Controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 250),
      vsync: this,
    )..addStatusListener((status) {
        setState(() {});
      });
    _animationButton2Controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 250),
      vsync: this,
    )..addStatusListener((status) {
        setState(() {});
      });
    _animationButton3Controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 250),
      vsync: this,
    )..addStatusListener((status) {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationButton1Controller.dispose();
    _animationButton2Controller.dispose();
    _animationButton3Controller.dispose();
    super.dispose();
  }

  bool? get _isToggleButton1 {
    switch (_animationButton1Controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }

  bool? get _isToggleButton2 {
    switch (_animationButton2Controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }

  bool? get _isToggleButton3 {
    switch (_animationButton3Controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .05),
      child: Column(
        children: [
          SizedBox(
            height: width * .2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CloseAppButton(),
              Introduction(),
              MenuButton(),
            ],
          ),
          SizedBox(
            height: width * .07,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .13),
            width: width,
            height: width * .35,
            padding: EdgeInsets.symmetric(
              horizontal: width * .05,
              vertical: width * .045,
            ),
            decoration: BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                animatedHomeButton1(width),
                const SizedBox(
                  width: 5,
                ),
                animatedHomeButton2(width),
                const SizedBox(
                  width: 5,
                ),
                animatedHomeButton3(width),
              ],
            ),
          ),
          _isToggleButton3 != null && _isToggleButton3 == true
              ? AnimatedSubset(
                  animationButtonController: _animationButton3Controller,
                  titleButton1: 'برندها',
                  iconButton1: Icons.category_rounded,
                  routeButton1: Routes.brandsRoute,
                  titleButton2: 'کالاها',
                  iconButton2: Icons.fit_screen_rounded,
                  routeButton2: Routes.goodsRoute,
                  titleButton3: 'اشخاص',
                  iconButton3: Icons.person_search_rounded,
                  routeButton3: Routes.personsRoute,
                  titleButton4: 'انبارها',
                  iconButton4: Icons.warehouse_rounded,
                  routeButton4: Routes.warehouseRoute,
                )
              : const SizedBox(),
          _isToggleButton2 != null && _isToggleButton2 == true
              ? AnimatedSubset(
                  animationButtonController: _animationButton2Controller,
                  titleButton1: 'موجودی',
                  iconButton1: Icons.hourglass_empty_rounded,
                  routeButton1: Routes.stockRoute,
                  titleButton2: 'انبارگردانی',
                  iconButton2: Icons.published_with_changes_rounded,
                  routeButton2: '',
                  titleButton3: 'ورودی ها',
                  iconButton3: Icons.downloading_rounded,
                  routeButton3: '',
                  titleButton4: 'خروجی ها',
                  iconButton4: Icons.exit_to_app_rounded,
                  routeButton4: '',
                )
              : const SizedBox(),
          _isToggleButton1 != null && _isToggleButton1 == true
              ? AnimatedSubset(
                  animationButtonController: _animationButton1Controller,
                  titleButton1: 'ثبت\nورودی',
                  iconButton1: Icons.add_box,
                  routeButton1: Routes.incomingListsRoute,
                  titleButton2: 'ثبت\nخروجی',
                  iconButton2: Icons.indeterminate_check_box,
                  routeButton2: '',
                  titleButton3: 'عملیات\nانبارگردانی',
                  iconButton3: Icons.numbers_rounded,
                  routeButton3: '',
                  titleButton4: 'انتقالی\nبین انبار',
                  iconButton4: Icons.transform_rounded,
                  routeButton4: '',
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  InkWell animatedHomeButton3(double width) {
    return InkWell(
      onTap: () {
        if (_isToggleButton3 != null && _isToggleButton3 == true) {
          _animationButton3Controller.reverse();
        } else {
          _animationButton1Controller.reverse();
          _animationButton2Controller.reverse();
          _animationButton3Controller.forward();
        }

        setState(() {
          isTappedButton1 = false;
          isTappedButton2 = false;
          isTappedButton3 = !isTappedButton3;

          HapticFeedback.lightImpact();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width / 6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isTappedButton3 == true
              ? ColorManager.darkPrimary
              : ColorManager.primary,
          boxShadow: isTappedButton3 == true
              ? [
                  BoxShadow(
                    color: ColorManager.shadow.withOpacity(.8),
                    blurRadius: 3,
                    offset: const Offset(1.5, 1.5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ColorManager.shadow,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(3, 3),
                  ),
                ],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: isTappedButton3 == true
                    ? ColorManager.secondary
                    : ColorManager.onPrimary,
                child: Icon(
                  Icons.settings_input_component_rounded,
                  color: isTappedButton3 == true
                      ? ColorManager.darkPrimary
                      : ColorManager.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'اطلاعات\nاولیه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isTappedButton3
                      ? ColorManager.secondary
                      : ColorManager.onPrimary,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell animatedHomeButton2(double width) {
    return InkWell(
      onTap: () {
        if (_isToggleButton2 != null && _isToggleButton2 == true) {
          _animationButton2Controller.reverse();
        } else {
          _animationButton1Controller.reverse();
          _animationButton3Controller.reverse();
          _animationButton2Controller.forward();
        }

        setState(() {
          isTappedButton1 = false;
          isTappedButton2 = !isTappedButton2;
          isTappedButton3 = false;

          HapticFeedback.lightImpact();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width / 6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isTappedButton2 == true
              ? ColorManager.darkPrimary
              : ColorManager.primary,
          boxShadow: isTappedButton2 == true
              ? [
                  BoxShadow(
                    color: ColorManager.shadow.withOpacity(.8),
                    blurRadius: 3,
                    offset: const Offset(1.5, 1.5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ColorManager.shadow,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(3, 3),
                  ),
                ],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: isTappedButton2 == true
                    ? ColorManager.secondary
                    : ColorManager.onPrimary,
                child: Icon(
                  Icons.app_registration_outlined,
                  color: isTappedButton2 == true
                      ? ColorManager.darkPrimary
                      : ColorManager.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'لیست\nگزارشات',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isTappedButton2
                      ? ColorManager.secondary
                      : ColorManager.onPrimary,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell animatedHomeButton1(double width) {
    return InkWell(
      onTap: () {
        if (_isToggleButton1 != null && _isToggleButton1 == true) {
          _animationButton1Controller.reverse();
        } else {
          _animationButton2Controller.reverse();
          _animationButton3Controller.reverse();
          _animationButton1Controller.forward();
        }

        setState(() {
          isTappedButton1 = !isTappedButton1;
          isTappedButton2 = false;
          isTappedButton3 = false;

          HapticFeedback.lightImpact();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width / 6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isTappedButton1 == true
              ? ColorManager.darkPrimary
              : ColorManager.primary,
          boxShadow: isTappedButton1 == true
              ? [
                  BoxShadow(
                    color: ColorManager.shadow.withOpacity(.8),
                    blurRadius: 3,
                    offset: const Offset(1.5, 1.5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ColorManager.shadow,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(3, 3),
                  ),
                ],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: isTappedButton1 == true
                    ? ColorManager.secondary
                    : ColorManager.onPrimary,
                child: Icon(
                  Icons.archive_rounded,
                  color: isTappedButton1 == true
                      ? ColorManager.darkPrimary
                      : ColorManager.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'خدمات\nانبارداری',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isTappedButton1
                      ? ColorManager.secondary
                      : ColorManager.onPrimary,
                  fontSize: FontSize.s12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // InkWell animatedHomeButton(
  //   double width,
  //   bool? isToggle,
  //   AnimationController mainButtonController,
  //   AnimationController otherButtonIController,
  //   AnimationController otherButtonIIController,
  //   int mainButtonNumber,
  //   IconData icon,
  //   String title,
  // ) {
  //   bool isTappedMainButton = false;
  //   return InkWell(
  //     onTap: () {
  //       if (isToggle != null && isToggle == true) {
  //         mainButtonController.reverse();
  //       } else {
  //         otherButtonIController.reverse();
  //         otherButtonIIController.reverse();
  //         mainButtonController.forward();
  //       }

  //       setState(() {
  //         switch (mainButtonNumber) {
  //           case 1:
  //             isTappedButton1 = !isTappedButton1;
  //             isTappedButton2 = false;
  //             isTappedButton3 = false;
  //             isTappedMainButton = isTappedButton1;
  //             break;
  //           case 2:
  //             isTappedButton1 = false;
  //             isTappedButton2 = !isTappedButton2;
  //             isTappedButton3 = false;
  //             isTappedMainButton = isTappedButton2;
  //             break;
  //           case 3:
  //             isTappedButton1 = false;
  //             isTappedButton2 = false;
  //             isTappedButton3 = !isTappedButton3;
  //             isTappedMainButton = isTappedButton3;
  //             break;
  //         }
  //         log(isTappedMainButton.toString());
  //         log('button 1 is $isTappedButton1');

  //         HapticFeedback.lightImpact();
  //       });
  //     },
  //     child: AnimatedContainer(
  //       duration: const Duration(microseconds: 50),
  //       curve: Curves.fastLinearToSlowEaseIn,
  //       width: width / 6,
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: isTappedMainButton == true
  //             ? ColorManager.darkPrimary
  //             : ColorManager.primary,
  //         boxShadow: isTappedMainButton == true
  //             ? [
  //                 BoxShadow(
  //                   color: ColorManager.shadow.withOpacity(.8),
  //                   blurRadius: 3,
  //                   offset: const Offset(1.5, 1.5),
  //                 ),
  //               ]
  //             : [
  //                 BoxShadow(
  //                   color: ColorManager.shadow,
  //                   blurRadius: 5,
  //                   spreadRadius: 0,
  //                   offset: const Offset(3, 3),
  //                 ),
  //               ],
  //         borderRadius: const BorderRadius.all(
  //           Radius.circular(20),
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Expanded(
  //             child: CircleAvatar(
  //               backgroundColor: isTappedMainButton == true
  //                   ? ColorManager.secondary
  //                   : ColorManager.onPrimary,
  //               child: Icon(
  //                 icon,
  //                 color: isTappedMainButton == true
  //                     ? ColorManager.darkPrimary
  //                     : ColorManager.primary,
  //               ),
  //             ),
  //           ),
  //           FittedBox(
  //             fit: BoxFit.scaleDown,
  //             child: Text(
  //               title,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: isTappedMainButton
  //                     ? ColorManager.secondary
  //                     : ColorManager.onPrimary,
  //                 fontSize: FontSize.s12,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
