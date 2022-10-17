import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#7897ab');
  static Color darkPrimary = HexColor.fromHex('#9f97ab');
  static Color primaryOpacity70 = HexColor.fromHex('#B37897ab');
  static Color primaryContainer = HexColor.fromHex('#fdceb9');
  static Color secondary = HexColor.fromHex('#d885a3');
  static Color secondaryOpacity70 = HexColor.fromHex('#B3d885a3');
  static Color error = HexColor.fromHex('#a44a3f');
  static Color grey = HexColor.fromHex('#737477');
  static Color grey1 = HexColor.fromHex('#707070');
  static Color grey2 = HexColor.fromHex('#797979');
  static Color lightGrey = HexColor.fromHex('#9E9E9E');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color white = HexColor.fromHex('#FFFFFF');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; //! 8 Char with 100% opacity
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
