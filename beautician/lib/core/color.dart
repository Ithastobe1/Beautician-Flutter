import 'package:flutter/material.dart';

MaterialColor appcolorscode(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r))).round(),
        g + ((ds < 0 ? g : (255 - g))).round(),
        b + ((ds < 0 ? b : (255 - b))).round(),
        1);
  }
  return MaterialColor(color.value, swatch);
}

// Map<int, Color> color = {
//   50: const Color.fromRGBO(136, 14, 79, .1),
//   100: const Color.fromRGBO(136, 14, 79, .2),
//   200: const Color.fromRGBO(136, 14, 79, .3),
//   300: const Color.fromRGBO(136, 14, 79, .4),
//   400: const Color.fromRGBO(136, 14, 79, .5),
//   500: const Color.fromRGBO(136, 14, 79, .6),
//   600: const Color.fromRGBO(136, 14, 79, .7),
//   700: const Color.fromRGBO(136, 14, 79, .8),
//   800: const Color.fromRGBO(136, 14, 79, .9),
//   900: const Color.fromRGBO(136, 14, 79, 1),
// };
// MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

class AppColors {
  static Color primaryColor = appcolorscode(const Color(0xffEB112E));
  static Color backGroundColor = appcolorscode(const Color(0xFFE09990));
  // static Color primaryColor = const Color(0xffEB210E);
  // static Color backGroundColor = const Color(0xFFE15050);
  static Color white = const Color(0xFFF3F5FC);
  static Color dividerColor = const Color(0xFFD8D8D8);
  static Color green = const Color(0xFF8AC340);
  static Color skyBlue = const Color(0xFF26A5DE);
  static Color skyBlue10 = const Color(0xFF4E89AE);
  static Color parpel = const Color(0xFF65308B);
  static Color red = const Color(0xFFF05A2A);
  static Color blue = const Color(0xFF2A63D4);
  static Color borderColor = const Color(0xFF707070);
  static Color grey = const Color(0xFFA5A5A5);
  static Color black = const Color(0xFF0D0D0D);
  static Color shadowRed = const Color(0xFFE15050);
  static Color yellowColor = const Color(0xFFEDC33A);
  static Color devideColor = const Color(0xFF6890B8);
  static Color colorGray = const Color(0xFF707070);
  static Color pageBackground = const Color(0xFF1D1D27);
  static Color deepRed = const Color(0xffEB210E);
  static Color appBarColor = const Color(0xff0D0D0D);

  static Color searchBorderColor = const Color(0xffFAFAFA);
  static Color fillBorderColor = const Color(0xff1D1D1D);
  static Color textFieldTextColor = const Color(0xff6D6E72);
  static Color appAmber = const Color(0xffEDC33A);
  static Color switchActive = const Color(0xffEB210E);
  static Color helpTextColor = const Color(0xffE8E8E8);
  static Color shareTextColor = const Color(0xff666666);
  static Color greenButton = const Color(0xff56B665);

  ///dark theme
  static Color darkScaffoldBackgroundColor = const Color(0xFF1D1D27);
  static Color darkHeadline1 = const Color(0xFFffffff);
  static Color darkHeadline4 = const Color(0xFF707070);

  //dark app bar
  static Color darkAppBarTitleTextColor = const Color(0xFFffffff);
  static Color darkAppBarBackgroundColor = const Color(0xff0D0D0D);

  //card color
  static Color darkCardColor = const Color(0xff0D0D0D);

  /// light theme color

  static Color lightScaffoldBackgroundColor = const Color(0xffE4E7EA);
  static Color lightHeadline1 = const Color(0xFF1D1D27);
  static Color lightHeadline4 = const Color(0xFF0D0D0D);

  //light app bar
  static Color lightAppBarTitleTextColor = const Color(0xff1D1D27);
  static Color lightAppBarBackgroundColor = const Color(0xFFFFFFFF);

  //card color
  static Color lightCardColor = const Color(0xFFFFFFFF);

  // icon color
  // static Color iconColor = const Color(0x707070);
  static Color glowRed = const Color(0xffEFA0A0);
  static Color themecolors = Color.fromARGB(255, 19, 1, 1);
  static Color wordcolors = const Color(0xFFFFFFFF);
}
