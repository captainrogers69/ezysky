import 'package:flutter/material.dart';

/// First Word is For [MOBILE] end Second [TABLET]
extension BuildContextExt on BuildContext {
  // bool get isMobile => Responsive.isMobile(this);
  // EdgeInsets get padding => MediaQuery.paddingOf(this);
  Size get size => MediaQuery.sizeOf(this);
}

class Responsive extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  final Widget tablet;
  const Responsive({
    required this.desktop,
    required this.mobile,
    required this.tablet,
    super.key,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // static MediaQueryData _mediaQueryData(context) => MediaQuery.of(context);
  // static double screenWidth(context) => _mediaQueryData(context).size.width;
  // static double screenHeight(context) => _mediaQueryData(context).size.height;
  // static Orientation orientation(context) =>
  //     _mediaQueryData(context).orientation;

  // static final window = WidgetsBinding.instance.window;
  // static Size size = window.physicalSize / window.devicePixelRatio;
  // static double getHorizontalSize(double px) => px * (size.width / 375);

  @override
  Widget build(BuildContext context) {
    // log(MediaQuery.of(context).size.width.toString(), name: "SIzed here");
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
