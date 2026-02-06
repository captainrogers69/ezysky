import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '/components/sizing_box.dart';
import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class KHomeHeading extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final void Function()? onViewAll;
  final bool sheetHeading;
  final TextStyle? style;
  final Widget? trailing;
  final String title;
  const KHomeHeading({
    this.sheetHeading = false,
    required this.title,
    this.onViewAll,
    this.trailing,
    this.padding,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style ??
                Kstyles.kHintStyle.copyWith(
                  fontSize: sheetHeading ? 20 : null,
                  color: KColors.blackColor,
                ),
          ),
          if (trailing != null)
            trailing ?? SizedBox.shrink()
          else if (onViewAll != null)
            TextButton(
              onPressed: () => onViewAll!(),
              child: Text(
                "View All",
                style: TextStyle(
                  decorationColor: KColors.grey500,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  color: KColors.grey500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HeadingH extends StatelessWidget {
  final String title;
  final Color? color;
  const HeadingH({required this.title, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Text(
        title,
        style: Kstyles.kHeading1Style.copyWith(
          fontWeight: FontWeight.bold,
          color: color ?? KColors.grey900,
        ),
      ),
    );
  }
}

class ExpansionTrailingCheckbox extends StatelessWidget {
  final ValueNotifier<bool> isSame;
  final bool arrow;
  final String title;
  const ExpansionTrailingCheckbox({
    required this.isSame,
    this.arrow = false,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Kstyles.kHeading1Style.copyWith(
              fontWeight: FontWeight.w600,
              color: KColors.primaryColor,
            ),
          ),
          const Sbw(w: 5),
          Visibility(
            visible: !arrow,
            replacement: Icon(
              Icons.arrow_forward_ios,
              color: KColors.grey600,
              size: 15,
            ),
            child: Icon(
              isSame.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank_outlined,
              color: isSame.value ? KColors.primaryColor : null,
              weight: 70,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionTrailing extends StatelessWidget {
  final ValueNotifier<bool> isExpanded;
  const ExpansionTrailing({required this.isExpanded, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            !isExpanded.value ? "Less" : "More",
            style: Kstyles.kHeading1Style.copyWith(
              fontWeight: FontWeight.w600,
              color: KColors.primaryColor,
              fontSize: 20,
            ),
          ),
          const Sbw(w: 5),
          Icon(
            !isExpanded.value
                ? IconlyLight.arrow_up_circle
                : IconlyLight.arrow_down_circle,
            color: KColors.primaryColor,
            size: 24,
          )
        ],
      ),
    );
  }
}
