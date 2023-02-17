import 'package:flutter/material.dart';

import 'styles_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';
import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontConstants.fontFamily,
    // colorScheme: ColorScheme(
    //   brightness: Brightness.light,
    //   primary: ColorManager.primary,
    //   onPrimary: ColorManager.onPrimary,
    //   primaryContainer: ColorManager.primaryContainer,
    //   onPrimaryContainer: ColorManager.onPrimaryContainer,
    //   secondary: ColorManager.secondary,
    //   onSecondary: ColorManager.onSecondary,
    // secondaryContainer: ColorManager.secondaryContainer,
    // onSecondaryContainer: ColorManager.onSecondaryContainer,
    // tertiary: ColorManager.tertiary,
    // onTertiary: ColorManager.onTertiary,
    // tertiaryContainer: ColorManager.tertiaryContainer,
    // onTertiaryContainer: ColorManager.onTertiaryContainer,
    // error: ColorManager.error,
    // onError: ColorManager.onError,
    // errorContainer: ColorManager.errorContainer,
    // onErrorContainer: ColorManager.onErrorContainer,
    // background: ColorManager.background,
    // onBackground: ColorManager.onBackground,
    // surface: ColorManager.surface,
    // onSurface: ColorManager.onSurface,
    // surfaceVariant: ColorManager.surfaceVariant,
    // onSurfaceVariant: ColorManager.onSurfaceVariant,
    // outline: ColorManager.outline,
    // inverseSurface: ColorManager.inverseSurface,
    // onInverseSurface: ColorManager.onInverseSurface,
    // inversePrimary: ColorManager.inversePrimary,
    // surfaceTint: ColorManager.surfaceTint,
    // shadow: ColorManager.shadow,
    // ),

    //* Main colors of the app
    primaryColor: ColorManager.primary,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.secondary),
    disabledColor: ColorManager.grey1,

    // //* Card view theme
    // cardTheme: CardTheme(
    //   color: ColorManager.white,
    //   shadowColor: ColorManager.grey,
    //   elevation: AppSize.s4,
    // ),

    // //* App bar theme
    // appBarTheme: AppBarTheme(
    //   centerTitle: true,
    //   color: ColorManager.primary,
    //   elevation: AppSize.s4,
    //   shadowColor: ColorManager.primaryOpacity70,
    //   titleTextStyle: getRegularStyle(
    //     color: ColorManager.white,
    //     fontSize: FontSize.s16,
    //   ),
    // ),

    // //* Button theme
    // buttonTheme: ButtonThemeData(
    //   shape: const StadiumBorder(),
    //   disabledColor: ColorManager.grey1,
    //   buttonColor: ColorManager.secondary,
    // ),

    //* Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.onPrimary),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
      ),
    ),

    //* Text theme
    textTheme: TextTheme(
      headline1: getBoldStyle(
        color: ColorManager.background,
        fontSize: FontSize.s20,
      ),
      headline2: getBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      subtitle1: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s16,
      ),
      subtitle2: getMediumStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      caption: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.onPrimaryContainer,
        fontSize: FontSize.s16,
      ),
      bodyText2: getRegularStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s16,
      ),
      headline3: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s12,
      ),
    ),

    //* Input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManager.onSecondary.withOpacity(.4)),
      labelStyle: getMediumStyle(color: ColorManager.onSecondary),
      errorStyle: getRegularStyle(color: ColorManager.onError),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.secondary,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
