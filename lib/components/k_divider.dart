// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';

class KDivider extends StatelessWidget {
  final double? vertical, vert;
  const KDivider({this.vertical = 9, this.vert, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: vert ?? 2.5.sp),
      margin: EdgeInsets.symmetric(vertical: vertical!),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
    );
  }
}

class RegularDivider extends StatelessWidget {
  final double? horizontal, thick, vertical;
  final Color? color;
  const RegularDivider({
    this.horizontal,
    this.thick,
    this.vertical,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 5,
        vertical: vertical ?? 0,
      ),
      child: Divider(
        thickness: thick ?? .5, //1,
        color: color ?? Colors.black,
      ),
    );
  }
}

class NoSpaceDivider extends StatelessWidget {
  final double? horizontal, thick, vertical;
  final Color? color;
  const NoSpaceDivider({
    this.horizontal,
    this.thick,
    this.vertical,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal ?? 20,
        vertical: vertical ?? 0,
      ),
      child: Container(
        height: thick ?? 1,
        color: color ?? KColors.whiteColor,
      ),
    );
  }
}

class VerticallyDivider extends StatelessWidget {
  final double? height, width;
  final Color? color;
  const VerticallyDivider({
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 21,
      width: width ?? 1.4,
      color: color ?? Colors.grey[400],
    );
  }
}

class AboutDivider extends StatelessWidget {
  final double? horizontal;
  final Color? color;
  const AboutDivider({
    this.horizontal,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 20),
      child: Divider(
        color: color ?? Colors.black.withOpacity(0.6),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final String title;
  final double horizontal;
  const OrDivider({this.title = 'Or', this.horizontal = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 1.5)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              // style: Kstyles.kSmallTextStyle.copyWith(
              //   fontSize: 17,
              // ),
            ),
          ),
          const Expanded(child: Divider(thickness: 1.5)),
        ],
      ),
    );
  }
}
