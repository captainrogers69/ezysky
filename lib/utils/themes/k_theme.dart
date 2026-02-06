import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/k_colors.dart';
import '../constants/k_styles.dart';

class KTheme {
  KTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: KColors.whiteColor,
    ),
    scaffoldBackgroundColor: KColors.whiteColor,
    // scaffoldBackgroundColor: KColors.grey100,
    primaryColor: KColors.primaryColor,
    cardColor: Colors.white,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: KColors.primaryColor,
      titleTextStyle: Kstyles.kAppBarTextStyle.copyWith(color: KColors.grey600),
      iconTheme: const IconThemeData(color: KColors.whiteColor),
      actionsIconTheme: const IconThemeData(color: KColors.whiteColor),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    buttonTheme: const ButtonThemeData(buttonColor: KColors.whiteColor),
    // colorScheme: ColorScheme(background: Colors.black)
  );
  static final darkTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: KColors.whiteColor,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: KColors.whiteColor,
    // scaffoldBackgroundColor: const Color(0xFF0f101c),
    primaryColor: KColors.primaryColor,
    cardColor: Colors.white,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    appBarTheme: const AppBarTheme(
      color: KColors.whiteColor,
      iconTheme: IconThemeData(color: KColors.whiteColor),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xffffffff))),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
    // colorScheme: ColorScheme(background: Colors.white)
  );
}
