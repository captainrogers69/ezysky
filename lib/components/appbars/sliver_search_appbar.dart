// import 'package:flutter/material.dart';
// import 'package:intelligere/utils/constants/k_colors.dart';
// import 'package:intelligere/utils/constants/k_styles.dart';
// import 'package:sizer/sizer.dart';

// class SearchSliverAppbar extends StatelessWidget
//     implements PreferredSizeWidget {
//   final String title, subTitle;
//   final List<Widget>? actions;
//   final TextEditingController controller;
//   final void Function() micPressed;
//   final Function(String v)? onChanged;
//   final Widget? bottom;

//   const SearchSliverAppbar({
//     required this.micPressed,
//     required this.controller,
//     required this.subTitle,
//     required this.title,
//     this.onChanged,
//     this.actions,
//     this.bottom,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: true,
//       centerTitle: false,
//       backgroundColor: KColors.primaryColor,
//       leading: const BackButton(color: KColors.whiteColor),
//       title: Text(
//         title,
//         style: Kstyles.kAppBarTextStyle.copyWith(
//           fontFamily: 'Poppins',
//           color: KColors.whiteColor,
//         ),
//       ),
//       actions: actions ?? [],
//       bottom: PreferredSize(
//         // preferredSize: Size.fromHeight(100.h * 0.045),

//         preferredSize: Size.fromHeight(6.h),
//         child: bottom ??
//             AppBarSearch(
//               micPressed: micPressed,
//               onChanged: onChanged,
//               title: subTitle,
//               controller: controller,
//             ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(actions != null ? 12.h : 11.h
//       // preferredSize: Size.fromHeight(5.h),
//       // 100.h * 0.07 + AppBar().preferredSize.height,
//       );
// }

// class AppBarSearch extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String v)? onChanged;
//   final void Function() micPressed;
//   final Widget? needDropDown;
//   final bool appbarBorderSearch;
//   final String? title;
//   const AppBarSearch({
//     required this.micPressed,
//     required this.controller,
//     this.appbarBorderSearch = false,
//     required this.title,
//     this.needDropDown,
//     this.onChanged,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Flexible(
//           child: InkWell(
//             onTap: () {},
//             splashColor: KColors.transparentColor,
//             highlightColor: KColors.transparentColor,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5)
//                   .copyWith(bottom: 7),
//               padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(
//                 right: 4,
//               ),
//               height: 45,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: !appbarBorderSearch
//                       ? KColors.whiteColor
//                       : KColors.grey500,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//                 color: KColors.whiteColor,
//               ),
//               alignment: Alignment.center,
//               child: TextFormField(
//                 textAlignVertical: TextAlignVertical.center,
//                 onChanged: onChanged,
//                 controller: controller,
//                 onTapOutside: (event) {
//                   FocusManager.instance.primaryFocus?.unfocus();
//                 },
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.only(bottom: 4),
//                   border: InputBorder.none,
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: KColors.grey500,
//                   ),
//                   hintText: title ?? '',
//                   hintStyle: Kstyles.kSmallTextStyle,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         needDropDown == null ? const SizedBox() : needDropDown!,
//       ],
//     );
//   }
// }
