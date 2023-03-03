import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'home_button.dart';
import '../../resources/import_resources.dart';

class AnimatedSubset extends StatelessWidget {
  const AnimatedSubset({
    Key? key,
    required AnimationController animationButtonController,
    required this.titleButton1,
    required this.iconButton1,
    required this.routeButton1,
    required this.titleButton2,
    required this.iconButton2,
    required this.routeButton2,
    required this.titleButton3,
    required this.iconButton3,
    required this.routeButton3,
    required this.titleButton4,
    required this.iconButton4,
    required this.routeButton4,
  })  : _animationButtonController = animationButtonController,
        super(key: key);

  final AnimationController _animationButtonController;
  final String titleButton1;
  final IconData iconButton1;
  final String routeButton1;
  final String titleButton2;
  final IconData iconButton2;
  final String routeButton2;
  final String titleButton3;
  final IconData iconButton3;
  final String routeButton3;
  final String titleButton4;
  final IconData iconButton4;
  final String routeButton4;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animationButtonController,
      builder: (context, child) {
        return FadeScaleTransition(
          animation: _animationButtonController,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
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
            children: [
              HomeButton(
                title: titleButton1,
                icon: iconButton1,
                routeName: routeButton1,
              ),
              HomeButton(
                title: titleButton2,
                icon: iconButton2,
                routeName: routeButton2,
              ),
              HomeButton(
                title: titleButton3,
                icon: iconButton3,
                routeName: routeButton3,
              ),
              HomeButton(
                title: titleButton4,
                icon: iconButton4,
                routeName: routeButton4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
