import 'package:flutter/material.dart';
import 'package:squareboat/components/app_tooltip.dart';
import 'package:squareboat/utils/constants/k_colors.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    this.label,
    this.labelStyle,
    this.isRequired = false,
    this.endLabel,
    required this.child,
    this.vs = 4,
    this.tooltipText,
    this.tooltipIcon,
    this.toolTipStyle,
    this.errorMessage,
    this.errorStyle,
    this.hideErrorText = false,
    this.labelPadding,
  });

  final String? label;
  final EdgeInsets? labelPadding;
  final TextStyle? labelStyle;
  final bool isRequired;
  final Widget? endLabel;
  final Widget child;
  final double vs;
  final String? tooltipText;
  final Widget? tooltipIcon;
  final TextStyle? toolTipStyle;
  final String? errorMessage;
  final TextStyle? errorStyle;
  final bool hideErrorText;

  @override
  Widget build(BuildContext context) {
    // final appSize = AppSize.fromSize(context);

    final hasError =
        !hideErrorText && errorMessage != null && errorMessage!.isNotEmpty;
    final hasLabel = label != null && label!.isNotEmpty;
    final hasTooltip = tooltipText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel || hasError || hasTooltip) ...[
          Padding(
            padding: labelPadding ?? EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (hasLabel)
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: label,
                            style: labelStyle,
                          ),
                          TextSpan(
                            text: isRequired ? '*' : '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Tooltip next to label
                if (hasTooltip && !hasError) ...[
                  // 8.hs,
                  AppTooltip(
                    tooltipText: tooltipText,
                    tooltipIcon: tooltipIcon,
                    toolTipStyle: toolTipStyle,
                  ),
                ],
                // Endlabel also visible during error
                if (endLabel != null) ...[
                  // appSize.s8to12.hs,
                  endLabel!,
                ],
              ],
            ),
          ),
          if (hasError) ...[
            // 2.vs,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _ErrorWidget(
                    errorMessage: errorMessage!,
                    errorStyle: errorStyle,
                  ),
                ),
                if (hasTooltip) ...[
                  AppTooltip(
                    tooltipText: tooltipText,
                    tooltipIcon: tooltipIcon,
                    toolTipStyle: toolTipStyle,
                  ),
                ],
              ],
            ),
          ],
          // vs.vs,
        ],
        child
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final TextStyle? errorStyle;

  const _ErrorWidget({
    required this.errorMessage,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning,
            size: 16,
            color: KColors.errorColor,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              errorMessage,
              style: errorStyle?.copyWith(
                color: KColors.errorColor,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
