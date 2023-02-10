import 'package:flutter/material.dart';

class ShowModalBottomButton extends StatelessWidget {
  final Widget showModalChildWidget;
  final String buttonTitle;
  final IconData buttonIcon;
  const ShowModalBottomButton({
    Key? key,
    required this.showModalChildWidget,
    required this.buttonTitle,
    required this.buttonIcon,
  }) : super(key: key);

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: showModalChildWidget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      icon: Icon(buttonIcon),
      label: Text(buttonTitle),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
