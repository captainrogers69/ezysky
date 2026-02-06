// import 'package:flutter/material.dart';
// import 'package:intelligere/utils/constants/k_colors.dart';
// import 'package:intelligere/utils/constants/k_styles.dart';
// import 'package:sizer/sizer.dart';

// class WitSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool shouldBack;
//   final bool? noActions;
//   final String title;
//   final List<Widget>? actions;
//   final Widget? leading;
//   final double fontSize;
//   final Widget? titleWidget;
//   final Widget? bottom;
//   const WitSliverAppBar({
//     this.shouldBack = true,
//     this.noActions = false,
//     required this.title,
//     this.fontSize = 16,
//     this.titleWidget,
//     this.leading,
//     this.actions,
//     this.bottom,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return (shouldBack)
//         ? SliverAppBar(
//             stretch: true,
//             pinned: true,
//             centerTitle: false,
//             leading: leading ?? const BackButton(color: KColors.whiteColor),
//             automaticallyImplyLeading: shouldBack ? false : true,
//             actions: noActions! ? [] : actions ?? [],
//             title: titleWidget ??
//                 Text(
//                   title,
//                   style: Kstyles.kAppBarTextStyle.copyWith(
//                     fontSize: shouldBack ? 15.5.sp : 15.sp,
//                     color: KColors.whiteColor,
//                   ),
//                 ),
//           )
//         : SliverAppBar(
//             stretch: true,
//             pinned: true,
//             centerTitle: false,
//             automaticallyImplyLeading: shouldBack ? false : true,
//             actions: noActions! ? [] : actions ?? [],
//             title: titleWidget ??
//                 Text(
//                   title,
//                   style: Kstyles.kAppBarTextStyle.copyWith(
//                     color: KColors.whiteColor,
//                     fontSize: fontSize,
//                   ),
//                 ),
//           );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
// }
