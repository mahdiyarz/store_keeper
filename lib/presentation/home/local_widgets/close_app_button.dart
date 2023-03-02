import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/import_resources.dart';

class CloseAppButton extends StatelessWidget {
  const CloseAppButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.secondary,
      child: IconButton(
          onPressed: () => SystemNavigator.pop(),
          icon: Icon(
            Icons.close,
            color: ColorManager.primary,
          )),
    );
  }
}
