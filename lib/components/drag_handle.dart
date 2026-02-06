import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';
import '/utils/responsive/responsive.dart';

class DragHandle extends StatelessWidget {
  final double? width, height;
  final Color? color;
  const DragHandle({
    this.height,
    this.color,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: color ?? KColors.primaryColor,
                ),
                width: width ?? 17.w,
                height: height ?? 6,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
