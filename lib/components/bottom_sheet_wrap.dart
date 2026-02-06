import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';
import '/utils/helpers/app_helpers.dart';

class BottomSheetWrap extends StatelessWidget {
  final Widget child;
  final bool bottomSafearea, visible;
  const BottomSheetWrap(
      {this.bottomSafearea = true,
      required this.child,
      this.visible = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFooter(
      visible: visible,
      child: SafeArea(
        bottom: bottomSafearea,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: KHelpers.witBoxShadowstatic,
            color: KColors.whiteColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: Platform.isAndroid ? 8 : 20.sp,
                  top: 8,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedFooter extends StatelessWidget {
  final bool visible;
  final Widget child;
  const AnimatedFooter({
    required this.visible,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      opacity: visible ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        height: visible ? null : 0,
        child: child,
      ),
    );
  }
}
