import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#ffcda3');
  static Color onPrimary = HexColor.fromHex('#425c5a');
  static Color primaryContainer = HexColor.fromHex('#425c5a');
  static Color onPrimaryContainer = HexColor.fromHex('#FFFFFF');
  static Color secondary = HexColor.fromHex('#5b7775');
  static Color onSecondary = HexColor.fromHex('#FFFFFF');
  // static Color secondaryContainer = HexColor.fromHex('#5b7775');
  // static Color onSecondaryContainer = HexColor.fromHex('#FFFFFF');
  // static Color tertiary = HexColor.fromHex('#5B6300');
  // static Color onTertiary = HexColor.fromHex('#FFFFFF');
  // static Color tertiaryContainer = HexColor.fromHex('#E0EB76');
  // static Color onTertiaryContainer = HexColor.fromHex('#1A1D00');
  static Color error = HexColor.fromHex('#BA1A1A');
  static Color onError = HexColor.fromHex('#FFFFFF');
  // static Color errorContainer = HexColor.fromHex('#FFDAD6');
  // static Color onErrorContainer = HexColor.fromHex('#410002');
  static Color grey = HexColor.fromHex('#737477'); //!
  static Color grey1 = HexColor.fromHex('#707070'); //!
  static Color grey2 = HexColor.fromHex('#797979'); //!
  static Color lightGrey = HexColor.fromHex('#9E9E9E'); //!
  static Color darkGrey = HexColor.fromHex('#525252'); //!
  static Color white = HexColor.fromHex('#FFFFFF'); //!
  static Color background = HexColor.fromHex('#F3FFFA');
  static Color onBackground = HexColor.fromHex('#425c5a');
  static Color surface = HexColor.fromHex('#F3FFFA');
  static Color onSurface = HexColor.fromHex('#00201A');
  // static Color surfaceVariant = HexColor.fromHex('#F5DDD8');
  // static Color onSurfaceVariant = HexColor.fromHex('#534340');
  static Color outline = HexColor.fromHex('#85736F');
  // static Color inverseSurface = HexColor.fromHex('#00382E');
  // static Color onInverseSurface = HexColor.fromHex('#B7FFEC');
  // static Color inversePrimary = HexColor.fromHex('#FFB4A2');
  // static Color surfaceTint = HexColor.fromHex('#9C432E');
  // static Color outlineVariant = HexColor.fromHex('#D8C2BD');
  // static Color scrim = HexColor.fromHex('#000000');
  static Color shadow = HexColor.fromHex('#000000');
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

// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFFFFB4A2),
//   onPrimary: Color(0xFF5E1605),
//   primaryContainer: Color(0xFF7D2C19),
//   onPrimaryContainer: Color(0xFFFFDAD2),
//   secondary: Color(0xFFFFB95F),
//   onSecondary: Color(0xFF472A00),
//   secondaryContainer: Color(0xFF653E00),
//   onSecondaryContainer: Color(0xFFFFDDB8),
//   tertiary: Color(0xFFC3CE5D),
//   onTertiary: Color(0xFF2F3300),
//   tertiaryContainer: Color(0xFF444B00),
//   onTertiaryContainer: Color(0xFFE0EB76),
//   error: Color(0xFFFFB4AB),
//   errorContainer: Color(0xFF93000A),
//   onError: Color(0xFF690005),
//   onErrorContainer: Color(0xFFFFDAD6),
//   background: Color(0xFF00201A),
//   onBackground: Color(0xFF79F8DC),
//   surface: Color(0xFF00201A),
//   onSurface: Color(0xFF79F8DC),
//   surfaceVariant: Color(0xFF534340),
//   onSurfaceVariant: Color(0xFFD8C2BD),
//   outline: Color(0xFFA08C88),
//   onInverseSurface: Color(0xFF00201A),
//   inverseSurface: Color(0xFF79F8DC),
//   inversePrimary: Color(0xFF9C432E),
//   shadow: Color(0xFF000000),
//   surfaceTint: Color(0xFFFFB4A2),
//   // outlineVariant: Color(0xFF534340),
//   // scrim: Color(0xFF000000),
// );
