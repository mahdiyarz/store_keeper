import 'package:flutter/material.dart';

class IntroduceContainer extends StatelessWidget {
  const IntroduceContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width * .52,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
    );
  }
}
