import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class WitAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? drawerKey;
  final Widget? titleWidget, subtitleWidget;
  final List<Widget>? actions;
  final bool shouldBack;
  final bool? noActions;
  final String title;
  final Widget? leading;
  final double fontSize;
  // final Widget? bottom;
  const WitAppBar({
    this.drawerKey,
    this.subtitleWidget,
    this.shouldBack = true,
    this.noActions = false,
    required this.title,
    this.fontSize = 16,
    this.titleWidget,
    this.leading,
    this.actions,
    // this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return /* Responsive.isTablet(context) || Responsive.isDesktop(context)
        ? PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: AppBar(
              toolbarHeight: 120.0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: drawerKey != null
                  ? true
                  : shouldBack
                      ? false
                      : true,
              flexibleSpace: Container(),
              centerTitle: true,
              backgroundColor: KColors.primaryColor,
              elevation: 0,
              leadingWidth: 100,
              actions: noActions! ? [] : actions ?? [],
              leading: drawerKey != null
                  ? IconButton(
                      onPressed: () {
                        drawerKey?.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: KColors.whiteColor,
                        size: 40,
                      ),
                    )
                  : leading ??
                      IconButton(
                        onPressed: () {
                          ref.read(routingService).pop();
                        },
                        icon: Icon(
                          Platform.isAndroid
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios,
                          color: KColors.whiteColor,
                          size: 40,
                        ),
                      ),
              title: titleWidget ??
                  Text(
                    title,
                    style: Kstyles.kAppBarTextStyle.copyWith(
                      fontSize: shouldBack ? 15.5.sp : 15.sp,
                      color: KColors.primaryColor,
                    ),
                  ),
              shape: const Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
          )
        : */
        shouldBack
            ? AppBar(
                backgroundColor: KColors.primaryColor,
                // leadingWidth: Responsive.isMobile(context) ? 56 : 112,
                leading: leading ?? const BackButton(color: KColors.whiteColor),
                automaticallyImplyLeading: shouldBack ? false : true,
                actions: noActions! ? [] : actions ?? [],
                centerTitle: false,
                scrolledUnderElevation: 0,
                elevation: 0,
                title: Text(
                  title,
                  style: Kstyles.kAppBarTextStyle.copyWith(
                    color: KColors.whiteColor,
                  ),
                ),
              )
            : AppBar(
                backgroundColor: KColors.primaryColor,
                automaticallyImplyLeading: drawerKey != null
                    ? true
                    : shouldBack
                        ? false
                        : true,
                actions: noActions! ? [] : actions ?? [],
                centerTitle: false,
                scrolledUnderElevation: 0,
                elevation: 0,
                leading: leading ??
                    (drawerKey == null
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              try {
                                // drawerKey?.currentState?.openEndDrawer();
                                Scaffold.of(context).openDrawer();
                                // log("pressed $drawerKey::${drawerKey?.currentState} :: ${drawerKey?.currentWidget} :: ${drawerKey?.currentContext}");
                              } catch (e) {
                                log("pressed $e");
                              }
                              // DialogService.drawerkey.currentState?.openDrawer();
                              log("pressed");
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: KColors.whiteColor,
                            ),
                          )),
                leadingWidth: 0,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Kstyles.kAppBarTextStyle.copyWith(
                        color: KColors.whiteColor,
                      ),
                    ),
                    subtitleWidget ?? const SizedBox()
                  ],
                ),
              );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      /*  bottom != null
      ? 1.5 * AppBar().preferredSize.height: */
      AppBar().preferredSize.height);
}

// class _TitleRow extends ConsumerWidget {
//   const _TitleRow();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (!Responsive.isMobile(context))
//           SvgPicture.asset(
//             KAssets.drawerSwitch,
//           ),
//         if (!Responsive.isMobile(context)) SizedBox(width: 10),
//         CacheImage(
//           image: "https://i.pravatar.cc/150?img=4",
//         ),
//         SizedBox(width: 10),
//         Text(
//           "${ref.watch(authNotifierProvider).currentUser?.fullName}",
//           style: Kstyles.kAppBarTextStyle.copyWith(
//             color: KColors.whiteColor,
//           ),
//         ),
//         if (!Responsive.isMobile(context)) SizedBox(width: 10),
//         if (!Responsive.isMobile(context))
//           Text(
//             "Clocked in at ${DateFormat('hh:mm a').format(ref.watch(authNotifierProvider).clockedTime ?? DateTime.now())}",
//             style: Kstyles.kAppBarTextStyle.copyWith(
//               color: KColors.whiteColor,
//               fontSize: 12.sp,
//             ),
//           ),
//       ],
//     );
//   }
// }
