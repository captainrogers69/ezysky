import 'package:flutter/material.dart';

import 'responsive.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Responsive.isMobile(context) ? null : 600,
          child: child,
        ),
      ),
      mobile: child,
      tablet: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Responsive.isMobile(context) ? null : 600,
          child: child,
        ),
      ),
    );
  }
}
