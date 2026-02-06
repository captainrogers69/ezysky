import 'package:flutter/material.dart';
import 'package:squareboat/utils/constants/k_colors.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    this.toolTipStyle,
    this.tooltipIcon,
    this.textWidget,
    this.tooltipText,
    this.maxWidth,
    this.iconSize,
    this.child,
  });
  final TextStyle? toolTipStyle;
  final Widget? tooltipIcon;
  final Widget? textWidget;
  final String? tooltipText;
  final double? maxWidth;
  final double? iconSize;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final effectiveToolTipStyle = toolTipStyle;

    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      richMessage: WidgetSpan(
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? (200),
          ),
          child: tooltipText != null
              ? Text(
                  tooltipText!,
                  style: effectiveToolTipStyle?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: KColors.blackColor,
                    fontSize: effectiveToolTipStyle.fontSize != null
                        ? effectiveToolTipStyle.fontSize! * 0.9
                        : 12,
                  ),
                )
              : textWidget,
        ),
      ),
      // waitDuration: Duration(milliseconds: 200),
      showDuration: Duration(seconds: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: KColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      // child: child ??
      //     tooltipIcon ??
      //     SvgPicture.asset(
      //       ImageConstant.icTooltip,
      //       width: iconSize ?? 22,
      //       height: iconSize ?? 22,
      //       colorFilter: const ColorFilter.mode(
      //         KColors.blackColor,
      //         BlendMode.srcIn,
      //       ),
      //     ),
    );
  }
}
