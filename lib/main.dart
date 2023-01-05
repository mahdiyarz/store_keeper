import 'package:flutter/material.dart';

import '../presentation/error/error_view.dart';
import '../app/my_app.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>
      ErrorView(errorDetails: errorDetails);
  runApp(const MyApp());
}
