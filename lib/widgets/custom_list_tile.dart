import 'package:flutter/material.dart';

import '../presentation/resources/import_resources.dart';

class CustomListTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final IconData titleIcon;
  final IconData leftIcon;
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.titleIcon,
    required this.leftIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: ColorManager.secondary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorManager.primary,
                  maxRadius: 22,
                  child: Icon(
                    titleIcon,
                    color: ColorManager.onPrimary,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: ColorManager.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(leftIcon, color: ColorManager.onSecondary.withOpacity(.7)),
          ],
        ),
      ),
    );
  }
}
