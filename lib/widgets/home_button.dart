import 'package:flutter/material.dart';
import 'package:store_keeper/presentation/resources/font_manager.dart';

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
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(3, 3),
            ),
          ],
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [ColorManager.lightSecondary, ColorManager.secondary],
          // ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
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
