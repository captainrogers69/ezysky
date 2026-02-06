import 'package:flutter/material.dart';

import '/utils/constants/k_colors.dart';

class KTabbar extends StatelessWidget {
  final void Function(int)? onPressed;
  final TabController controller;
  final List<String> tabs;

  const KTabbar({
    super.key,
    required this.controller,
    required this.tabs,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: KColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: KColors.grey800, // selected pill color
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: KColors.grey700,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        onTap: onPressed,
        tabs: tabs.map(
          (title) {
            return Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    // horizontal: 12,
                    // vertical: 3,
                    ),
                child: Text(title),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
