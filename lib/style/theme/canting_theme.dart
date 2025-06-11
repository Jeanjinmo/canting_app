import 'package:canting_app/style/colors/canting_colors.dart';
import 'package:canting_app/style/typography/canting_typography.dart';
import 'package:flutter/material.dart';

class CantingTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CantingTextStyles.displayLarge,
      displayMedium: CantingTextStyles.displayMedium,
      displaySmall: CantingTextStyles.displaySmall,
      headlineLarge: CantingTextStyles.headlineLarge,
      headlineMedium: CantingTextStyles.headlineMedium,
      headlineSmall: CantingTextStyles.headlineSmall,
      titleLarge: CantingTextStyles.titleLarge,
      titleMedium: CantingTextStyles.titleMedium,
      titleSmall: CantingTextStyles.titleSmall,
      bodyLarge: CantingTextStyles.bodyLargeBold,
      bodyMedium: CantingTextStyles.bodyLargeMedium,
      bodySmall: CantingTextStyles.bodyLargeRegular,
      labelLarge: CantingTextStyles.labelLarge,
      labelMedium: CantingTextStyles.labelMedium,
      labelSmall: CantingTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      // shape: const BeveledRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(14),
      //     bottomRight: Radius.circular(14),
      //   ),
      // ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: CantingColors.warmRed.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: CantingColors.warmRed.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }
}
