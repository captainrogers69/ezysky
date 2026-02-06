import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';

class SearchTextfield extends StatelessWidget {
  final void Function(String?)? onChange;
  final void Function()? onFilterPressed;
  final TextEditingController search;
  final String hintText;
  const SearchTextfield({
    required this.hintText,
    this.onFilterPressed,
    required this.search,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: search,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      decoration: InputDecoration(
        fillColor: KColors.whiteColor,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        labelStyle: TextStyle(
          color: KColors.grey700,
          fontStyle: FontStyle.normal,
          fontSize: 15.sp,
        ),
        errorMaxLines: 5,
        counterText: '',
        contentPadding:
            const EdgeInsets.only(left: 16, right: 12, top: 12, bottom: 12),
        suffixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 20),
        prefixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 16),
        // errorStyle: context.appSize.tsXStoS.copyWith(
        //     color: KColors.errorColor, fontSize: context.isMobile ? 9 : 14),
        filled: true,
        // fillColor: KColors.whiteColor,
        suffixIcon: onFilterPressed == null
            ? null
            : IconButton(
                onPressed: () => onFilterPressed!(),
                icon: Icon(
                  IconlyLight.filter_2,
                  color: KColors.grey600,
                ),
              ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            IconlyLight.search,
            color: KColors.grey600,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.grey400),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.grey400),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.grey400),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.grey400),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.grey400),
            borderRadius: BorderRadius.circular(10)),
        isDense: true,
      ),
    );
  }
}
