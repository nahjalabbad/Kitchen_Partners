// ignore_for_file: use_full_hex_values_for_flutter_colors, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unnecessary_const, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../kitchenpartners_app.dart';
import '../logic/providers/theme_provider.dart';
import '../models/enum.dart';

bool isLightTheme = true;

class AppTheme {
  static bool get isLightMode {
    return applicationcontext == null
        ? true
        : applicationcontext!.read<ThemeProvider>().isLightMode;
  }

  // colors
  // ignore: prefer_const_constructors
  static Color get primaryColor =>
      isLightTheme ? Color(0xFF22A45D) : Color(0xFF22A45D);

  // ignore: prefer_const_constructors
  static Color get successColor =>
      isLightTheme ? Color(0xFF43B726) : Color(0xFF43B726);
  static Color get infoColor =>
      isLightTheme ? const Color(0xFF186DDD) : const Color(0xFF186DDD);
  static Color get warningColor =>
      isLightTheme ? const Color(0xFFF7DE00) : const Color(0xFFF7DE00);
  static Color get dangerColor =>
      isLightTheme ? const Color(0xFFE23D24) : const Color(0xFFE23D240);
  static Color get googleColor =>
      isLightTheme ? const Color(0xFF4285F4) : const Color(0xFF4285F4);
  static Color get facebookColor =>
      isLightTheme ? const Color(0xFF395998) : const Color(0xFF395998);

  // Fixed
  static Color get inputColor =>
      isLightMode ? const Color(0xFFF6F8FC) : const Color(0xFF2f3233);

  static Color get scaffoldBackgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF1f2123);
  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF1F2123);

  static Color get primaryTextColor =>
      isLightMode ? const Color(0xFF010F07) : const Color(0xFFFFFFFF);
  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFFadadad);

  static Color get whiteColor => const Color(0xFFFFFFFF);
  static Color get darkgreenColor => Color.fromARGB(255, 10, 40, 2);
  static Color get lightbrownColor => Color.fromARGB(255, 177, 168, 149);
  static Color get backColor => const Color(0xFF262626);

  static Color get fontcolor =>
      isLightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  static Color get darkTextColor =>
      isLightTheme ? const Color(0xFF010F07) : const Color(0xFF1F2123);

  static Color get whiteTextColor =>
      isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF2F3233);

  static Color get tabColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF2F3233);

  static Color get lightGrayTextColor =>
      isLightMode ? const Color(0xFF757575) : const Color(0xFFADADAD);

  static const String regularFont = 'Poppins-Regular';

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType _fontType = applicationcontext == null
        ? FontFamilyType.WorkSans
        : applicationcontext!.read<ThemeProvider>().fontType;
    return base.copyWith(
      headline1: getTextStyle(_fontType, base.headline1!), //f-size 96
      headline2: getTextStyle(_fontType, base.headline2!), //f-size 60
      headline3: getTextStyle(_fontType, base.headline3!), //f-size 48
      headline4: getTextStyle(_fontType, base.headline4!), //f-size 34
      headline5: getTextStyle(_fontType, base.headline5!), //f-size 24
      headline6: getTextStyle(
        _fontType,
        base.headline6!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 20
      button: getTextStyle(_fontType, base.button!), //f-size 14
      caption: getTextStyle(_fontType, base.caption!), //f-size 12
      bodyText1: getTextStyle(_fontType, base.bodyText1!), //f-size 16
      bodyText2: getTextStyle(_fontType, base.bodyText2!), //f-size 14
      subtitle1: getTextStyle(
        _fontType,
        base.subtitle1!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 16
      subtitle2: getTextStyle(_fontType, base.subtitle2!), //f-size 14
      overline: getTextStyle(_fontType, base.overline!), //f-size 10
    );
  }

  static TextStyle getTextStyle(
      FontFamilyType _fontFamilyType, TextStyle textStyle) {
    switch (_fontFamilyType) {
      case FontFamilyType.Montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.WorkSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.Varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.Satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.DancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.KaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shadowColor: secondaryTextColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(const Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Theme.of(applicationcontext!).dividerColor,
              offset: const Offset(4, 4),
              blurRadius: 8.0),
        ],
      );
  static get buttonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.all(const Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      );
  static get searchBarDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(const Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
          ),
        ],
      );

  static get boxDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
          ),
        ],
      );
}

enum ThemeModeType {
  system,
  dark,
  light,
}
