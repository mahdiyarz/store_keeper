import 'package:flutter/material.dart';

import '../presentation/resources/import_resources.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.routeName,
  }) : super(key: key);

  final String routeName;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacementNamed(routeName),
      child: Container(
        width: width / 6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              blurRadius: 20,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorManager.lightSecondary, ColorManager.secondary],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: ColorManager.darkPrimary,
                child: Icon(
                  icon,
                  color: ColorManager.white,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
