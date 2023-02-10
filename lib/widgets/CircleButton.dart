import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData iconShape;
  final Color iconColor;
  final String iconNamedRoute;
  const CircleButton({
    Key? key,
    required this.iconShape,
    required this.iconColor,
    required this.iconNamedRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      child: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(iconNamedRoute),
          icon: Icon(
            iconShape,
            color: iconColor,
          )),
    );
  }
}
