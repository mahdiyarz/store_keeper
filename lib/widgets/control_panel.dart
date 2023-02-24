import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../presentation/resources/import_resources.dart';
import 'home_button.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isTapped = false;

  @override
  void initState() {
    _animationController = AnimationController(
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
    _animationController.dispose();
    super.dispose();
  }

  bool? get _isToggle {
    switch (_animationController.status) {
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(
            height: width * .2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.secondary,
                child: IconButton(
                    onPressed: () => SystemNavigator.pop(),
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.primary,
                    )),
              ),
              Column(
                children: [
                  Center(
                      child: Text(
                    'انبار جیبی',
                    style: TextStyle(
                        color: ColorManager.onPrimaryContainer,
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
                      color: ColorManager.onPrimaryContainer,
                      fontSize: FontSize.s14,
                    ),
                  )),
                ],
              ),
              CircleAvatar(
                backgroundColor: ColorManager.secondary,
                child: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: ColorManager.primary,
                    )),
              ),
            ],
          ),
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
              color: ColorManager.secondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const HomeButton(
                  title: 'ورود کالا',
                  icon: Icons.archive_rounded,
                  routeName: Routes.incomingListsRoute,
                ),
                const SizedBox(
                  width: 5,
                ),
                const HomeButton(
                  title: 'انبار گردانی',
                  icon: Icons.app_registration_rounded,
                  routeName: '',
                ),
                const SizedBox(
                  width: 5,
                ),
                const HomeButton(
                  title: 'بروزرسانی',
                  icon: Icons.refresh_rounded,
                  routeName: '',
                ),
                const SizedBox(
                  width: 5,
                ),
                animatedHomeButton(width),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeScaleTransition(
                animation: _animationController,
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              child: Container(
                width: width,
                height: width * .35,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    HomeButton(
                      title: 'برندها',
                      icon: Icons.category_rounded,
                      routeName: Routes.brandsRoute,
                    ),
                    HomeButton(
                      title: 'کالاها',
                      icon: Icons.fit_screen_rounded,
                      routeName: Routes.goodsRoute,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell animatedHomeButton(double width) {
    return InkWell(
      onTap: () {
        if (_isToggle != null && _isToggle == true) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        setState(() {
          isTapped = !isTapped;
          HapticFeedback.lightImpact();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width / 6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isTapped ? ColorManager.darkPrimary : ColorManager.primary,
          boxShadow: isTapped
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
                backgroundColor:
                    isTapped ? ColorManager.secondary : ColorManager.onPrimary,
                child: Icon(
                  Icons.settings_outlined,
                  color: isTapped
                      ? ColorManager.darkPrimary
                      : ColorManager.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'راه اندازی',
                style: TextStyle(
                  color: isTapped
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
}
