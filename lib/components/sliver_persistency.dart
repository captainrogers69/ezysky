import 'package:flutter/material.dart';

class SliverPersistancyHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverPersistancyHeaderDelegate({
    this.expandedHeight = kToolbarHeight,
    required this.child,
  });
  final double expandedHeight;
  final Widget child;

  @override
  double get maxExtent => expandedHeight; // + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverPersistancyHeaderDelegate oldDelegate) {
    return true;
    // return maxHeight != oldDelegate.maxHeight ||
    //       minHeight != oldDelegate.minHeight ||
    //       child != oldDelegate.child;
  }
}
