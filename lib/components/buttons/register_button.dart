import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';
import '/utils/responsive/responsive.dart';

class RegisterButton extends StatelessWidget {
  final void Function() onPressed;
  final String? title;
  const RegisterButton({required this.onPressed, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: KColors.primaryColor.withValues(alpha: .2),
                  width: .76,
                ),
              ),
            ),
            backgroundColor: KColors.fetchMaterial(
              KColors.grey200,
            ),
            shadowColor: KColors.fetchMaterial(
              KColors.whiteColor,
            ),
          ),
          child: Text(
            title ?? "Register Here",
            style: Kstyles.kHintStyle.copyWith(
              color: KColors.primaryColor,
              fontSize: Responsive.isMobile(context) ? 16.sp : 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
