import 'package:flutter/material.dart';

class ScreensStyle extends StatelessWidget {
  final String screenTitle;
  final String screenDescription;
  final Widget screenWidget;
  final Widget bottomWidget;
  final Widget mainButton;

  const ScreensStyle({
    Key? key,
    required this.screenTitle,
    required this.screenDescription,
    required this.screenWidget,
    required this.bottomWidget,
    required this.mainButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, width / 20, width / 17, width / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            screenTitle,
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.black.withOpacity(.6),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: width / 45),
                          Text(
                            screenDescription,
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    screenWidget,
                    SizedBox(
                      height: width / 10,
                    )
                  ],
                ),
                Positioned(
                  left: width / 15,
                  top: width / 20,
                  child: mainButton,
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: width,
                    child: bottomWidget,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
