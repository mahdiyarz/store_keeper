import 'package:flutter/material.dart';

import '../presentation/resources/import_resources.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.title,
    required this.imageAssets,
    required this.routeName,
  }) : super(key: key);

  final String routeName;
  final String title;
  final String imageAssets;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorManager.lightSecondary, ColorManager.secondary],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(45),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Container(
              width: 100,
              height: 75,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  topLeft: Radius.circular(45),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Image.asset(imageAssets),
            ),
          ],
        ),
      ),
    );
  }
}
