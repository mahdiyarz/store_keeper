import 'package:flutter/material.dart';

class ScreensStyle extends StatelessWidget {
  final String title;
  final String description;
  final Widget body;
  final Widget actionIcon;
  final Widget bodyButton;

  const ScreensStyle({
    Key? key,
    required this.title,
    required this.description,
    required this.body,
    required this.actionIcon,
    required this.bodyButton,
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
                            title,
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.black.withOpacity(.6),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: width / 45),
                          Text(
                            description,
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
                    body,
                    SizedBox(
                      height: width / 10,
                    )
                  ],
                ),
                Positioned(
                  left: width / 15,
                  top: width / 20,
                  child: actionIcon,
                ),
                Positioned(
                  bottom: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: width,
                    child: bodyButton,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
