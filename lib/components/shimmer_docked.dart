// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDocked extends StatelessWidget {
  final bool stackedAction;
  final bool onlyTop, onlyBottom;
  final double? height, width;
  final double? radius;
  const ShimmerDocked({
    this.stackedAction = false,
    this.onlyBottom = false,
    this.onlyTop = false,
    this.radius,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[800]!,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: onlyTop
              ? BorderRadius.only(
                  topLeft: Radius.circular(radius ?? 11),
                  topRight: Radius.circular(radius ?? 11),
                )
              : onlyBottom
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(radius ?? 11),
                      bottomRight: Radius.circular(radius ?? 11),
                    )
                  : BorderRadius.all(
                      Radius.circular(radius ?? 11),
                    ),
        ),
      ),
    );
  }
}
