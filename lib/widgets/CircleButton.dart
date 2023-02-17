import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/resources/color_manager.dart';

class CircleButton extends StatelessWidget {
  final IconData iconShape;
  final String iconNamedRoute;
  const CircleButton({
    Key? key,
    required this.iconShape,
    required this.iconNamedRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.primary,
      child: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(iconNamedRoute),
          icon: Icon(
            iconShape,
            color: ColorManager.onPrimary,
          )),
    );
  }
}
