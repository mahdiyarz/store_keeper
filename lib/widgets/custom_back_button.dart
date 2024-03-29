import 'package:flutter/material.dart';

import '../presentation/resources/import_resources.dart';

class CustomBackButton extends StatelessWidget {
  final String pageRoute;
  const CustomBackButton({
    required this.pageRoute,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.primary,
      child: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(pageRoute);
          },
          icon: Icon(
            Icons.arrow_forward,
            color: ColorManager.onPrimary,
          )),
    );
  }
}
