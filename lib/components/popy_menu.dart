import 'package:flutter/material.dart';

import '/utils/constants/k_colors.dart';

class PopyMenu extends StatelessWidget {
  final List<PopupMenuEntry<int>> popUps;
  final Function(int) onSelected;
  final Offset? offset;
  final Widget? icon;
  const PopyMenu({
    required this.onSelected,
    required this.popUps,
    required this.icon,
    this.offset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // menuPadding: EdgeInsets.zero,
      surfaceTintColor: KColors.whiteColor,
      color: KColors.whiteColor,
      shadowColor: KColors.whiteColor,
      // lightGreyColor,
      elevation: 7,
      onOpened: () {
        // Vibrate.feedback(FeedbackType.success);
      },
      offset: offset ?? Offset.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      padding: const EdgeInsets.all(0),
      onSelected: onSelected,
      itemBuilder: (context) => popUps,
      icon: icon,
      //  Icon(
      //   icons ?? Icons.more_vert,
      //   color: whiteColor,
      // ),
    );
  }
}
