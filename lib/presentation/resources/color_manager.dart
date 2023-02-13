import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#b0d9d7'); //* update
  static Color darkPrimary = HexColor.fromHex('#96cace'); //* update
  static Color primaryOpacity70 = HexColor.fromHex('#b0d9d7ab'); //* update
  static Color primaryContainer = HexColor.fromHex('#c3e1e2'); //* update
  static Color secondary = HexColor.fromHex('#ff5a3d'); //* update
  static Color secondaryOpacity70 = HexColor.fromHex('#ff5a3da3'); //* update
  static Color error = HexColor.fromHex('#a44a3f');
  static Color grey = HexColor.fromHex('#737477');
  static Color grey1 = HexColor.fromHex('#707070');
  static Color grey2 = HexColor.fromHex('#797979');
  static Color lightGrey = HexColor.fromHex('#9E9E9E');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color shadow = HexColor.fromHex('#1A000000');
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
