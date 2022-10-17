import 'package:flutter/material.dart';

import '../presentation/resources/font_manager.dart';
import '../presentation/resources/color_manager.dart';
import '../app/my_app.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        color: ColorManager.error,
        child: Center(
          child: Text(
            details.exception.toString(),
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ),
      );
  runApp(const MyApp());
}
