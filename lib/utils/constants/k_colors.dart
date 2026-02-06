import 'package:flutter/material.dart';

class KColors {
  static WidgetStateProperty<Color> fetchMaterial(Color color) {
    return WidgetStateProperty.all<Color>(color);
  }

  static const Color scaffoldColor = Color(0xffF8F8F8);

  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  static const Color transparentColor = Colors.transparent;
  static const Color primaryColor = Color(0xff212121);
  static Color switchColor = Colors.green[300]!;

  static const Color errorColor = Color(0xffff5252);
  static Color darkErrorColor = Colors.red[700]!;
  static const Color successColor = Color(0xff468847);

  static const Color disabledButtonColor = Color(0xffe6e6e6);
  static const Color disabledButtonTextColor =
      Color.fromARGB(255, 127, 134, 149);
  static Color grey50 = Colors.grey[50]!;
  static Color grey100 = Colors.grey[100]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;
  static Color grey800 = Colors.grey[800]!;
  static Color grey900 = Colors.grey[900]!;
  static const Color primaryTextGreyColor = Color(0xff565c68);
  static const Color iconGreyColor = Color(0xff949c98);
  static const Color darkDarkGreyColor = Color(0xff666666);
  // static Color primaryColor = const Color(0xff2d9cdb);
}
