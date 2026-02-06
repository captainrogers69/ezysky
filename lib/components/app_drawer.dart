import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_assets.dart';
import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState>? drawerkey;
  final String version;
  final bool isTablet;
  const AppDrawer({
    required this.isTablet,
    required this.version,
    this.drawerkey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Drawer(
        backgroundColor: KColors.primaryColor,
        shape: Border(),
        child: SafeArea(
          child: Column(
            // spacing: 30.sp,
            children: [
              SizedBox(height: 24),
              if (!isTablet)
                PrimeDrawerItem(
                  onPressed: () {},
                  icon: KAssets.drawer1,
                  widget: Icon(
                    Icons.menu,
                    color: KColors.whiteColor,
                  ),
                ),
              PrimeDrawerItem(
                onPressed: () {},
                icon: KAssets.drawer5,
              ),
              PrimeDrawerItem(
                onPressed: () {},
                icon: KAssets.drawer4,
              ),
              PrimeDrawerItem(
                onPressed: () {},
                icon: KAssets.drawer3,
              ),
              PrimeDrawerItem(
                onPressed: () {},
                icon: KAssets.drawer2,
              ),
              PrimeDrawerItem(
                onPressed: () {},
                icon: KAssets.drawer1,
              ),
              PrimeDrawerItem(
                onPressed: () {},
                version: version,
                icon: KAssets.splashIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimeDrawerItem extends StatelessWidget {
  final void Function() onPressed;
  final String icon, version;
  final Widget? widget;
  const PrimeDrawerItem({
    required this.onPressed,
    required this.icon,
    this.version = '',
    this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      splashColor: KColors.transparentColor,
      highlightColor: KColors.transparentColor,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget ??
                SvgPicture.asset(
                  icon,
                ),
            if (version.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Text(
                      "ver $version",
                      style: Kstyles.kHintStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: KColors.whiteColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "FL 3.3.6",
                      style: Kstyles.kHintStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: KColors.whiteColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
