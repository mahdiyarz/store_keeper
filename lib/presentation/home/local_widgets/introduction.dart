import 'package:flutter/material.dart';

import '../../resources/import_resources.dart';

class Introduction extends StatelessWidget {
  const Introduction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
