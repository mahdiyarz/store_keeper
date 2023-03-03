import 'package:flutter/material.dart';

import '../../resources/import_resources.dart';

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
          color: ColorManager.primary,
          boxShadow: [
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
                backgroundColor: ColorManager.onPrimary,
                child: Icon(
                  icon,
                  color: ColorManager.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.onPrimary,
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
