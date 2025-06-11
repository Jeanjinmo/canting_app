import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CantingTextStyles {
  /// local font
  /// dipakai pada: Display, Headlines, Titles
  static const TextStyle _commonStyleLocal = TextStyle(
    fontFamily: 'RobotoFlex',
  );

  /// Google Fonts pubdev
  /// dipakai pada: Body, Labels
  static final TextStyle _commonStyleNetwork = GoogleFonts.poppins();

  /// kita pakai aja bawaan default flutter jadi kosongkan saja
  /// dokumentasi textstyle default: https://api.flutter.dev/flutter/material/TextTheme-class.html
  /// jika ingin mengcustom lakukan contoh seperti ini:
  ///   static TextStyle displayLarge = _commonStyle.copyWith(
  ///    fontSize: 57,
  ///    fontWeight: FontWeight.w700,
  ///    height: 1.11,
  ///    letterSpacing: -2,
  ///  );

  /// displayLarge Text Style
  static TextStyle displayLarge = _commonStyleLocal.copyWith();

  /// displayMedium Text Style
  static TextStyle displayMedium = _commonStyleLocal.copyWith();

  /// displaySmall Text Style
  static TextStyle displaySmall = _commonStyleLocal.copyWith();

  /// headlineLarge Text Style
  static TextStyle headlineLarge = _commonStyleLocal.copyWith();

  /// headlineMedium Text Style
  static TextStyle headlineMedium = _commonStyleLocal.copyWith();

  /// headlineMedium Text Style
  static TextStyle headlineSmall = _commonStyleLocal.copyWith();

  /// titleLarge Text Style
  static TextStyle titleLarge = _commonStyleLocal.copyWith();

  /// titleMedium Text Style
  static TextStyle titleMedium = _commonStyleLocal.copyWith();

  /// titleSmall Text Style
  static TextStyle titleSmall = _commonStyleLocal.copyWith();

  /// bodyLargeBold Text Style
  static TextStyle bodyLargeBold = _commonStyleNetwork.copyWith();

  /// bodyLargeMedium Text Style
  static TextStyle bodyLargeMedium = _commonStyleNetwork.copyWith();

  /// bodyLargeRegular Text Style
  static TextStyle bodyLargeRegular = _commonStyleNetwork.copyWith();

  /// labelLarge Text Style
  static TextStyle labelLarge = _commonStyleNetwork.copyWith();

  /// labelMedium Text Style
  static TextStyle labelMedium = _commonStyleNetwork.copyWith();

  /// labelSmall Text Style
  static TextStyle labelSmall = _commonStyleNetwork.copyWith();
}
