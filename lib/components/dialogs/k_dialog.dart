import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';
import '/utils/themes/k_theme.dart';

class KAlertDialog extends StatelessWidget {
  final String canceltitle, actiontitle;
  final void Function() onAction;
  final void Function() onCancel;
  final String title, subtitle;
  final List<Widget>? actions;
  const KAlertDialog({
    this.actiontitle = 'Yes',
    this.canceltitle = 'No',
    required this.onAction,
    required this.subtitle,
    required this.onCancel,
    required this.title,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KTheme.lightTheme.copyWith(
        primaryColor: KColors.primaryColor,
      ),
      child: CupertinoAlertDialog(
        title: Text(
          title,
          style: Kstyles.kHintStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: KColors.blackColor,
            fontSize: 21,
          ),
        ),
        content: Text(
          subtitle,
          style: Kstyles.kHintStyle.copyWith(
            fontSize: 16,
          ),
        ),
        actions: actions ??
            [
              CupertinoDialogAction(
                onPressed: onCancel,
                child: Text(
                  canceltitle,
                  style: Kstyles.kButtonStyle.copyWith(
                    color: KColors.primaryColor,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: onAction,
                child: Text(
                  actiontitle,
                  style: Kstyles.kButtonStyle.copyWith(
                    color: KColors.primaryColor,
                  ),
                ),
              ),
            ],
      ),
    );
  }
}
