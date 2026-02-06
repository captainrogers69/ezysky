import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class DetailTextfield extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled, expands, isDense, autoFocus;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextCapitalization txtCapital;
  final InputDecoration? decoration;
  final String? hintText, labelText;
  final TextInputType? keyBoardType;
  final int? maxLength, maxLines;
  final Widget? suffix, prefix;
  final bool onlyleftpadding, obsecure;
  final AutovalidateMode? autovalidateMode;
  const DetailTextfield(
      {this.txtCapital = TextCapitalization.none,
      required this.controller,
      required this.labelText,
      this.onlyleftpadding = false,
      this.autovalidateMode,
      required this.hintText,
      this.inputFormatters,
      this.expands = false,
      this.enabled = true,
      this.isDense = false,
      this.autoFocus = false,
      this.obsecure = false,
      this.maxLines = 1,
      this.keyBoardType,
      this.decoration,
      this.maxLength,
      this.validator,
      this.onChanged,
      this.suffix,
      this.prefix,
      super.key});

  @override
  Widget build(BuildContext context) {
    // log("autofocust: $autoFocus");
    return Container(
      // decoration: BoxDecoration(
      //   boxShadow: witBoxShadow,
      //   color: whiteColor,
      // ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12).copyWith(
        right: onlyleftpadding ? 0 : 12,
        left: 12,
      ),
      // padding: const EdgeInsets.all(5),
      child: TextFormField(
        textCapitalization: txtCapital,
        maxLines: maxLines,
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        validator: validator ??
            (val) {
              return null;
            },
        inputFormatters: inputFormatters,
        keyboardType: keyBoardType,
        maxLength: maxLength,
        expands: expands,
        style: Kstyles.kSmallTextStyle.copyWith(
          color: KColors.grey800,
          fontSize: 16,
        ),
        obscureText: obsecure,
        autofocus: autoFocus,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        decoration: decoration ??
            InputDecoration(
              isDense: isDense,
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: suffix,
              prefixIcon: prefix,
              counterText: '',
              // hintStyle: Kstyles.kSmallTextStyle,
              labelText: labelText,
              hintStyle: Kstyles.kHintStyle.copyWith(
                color: KColors.grey800,
                fontSize: 16,
              ),
              labelStyle: Kstyles.kHintStyle.copyWith(
                color: KColors.primaryColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: KColors.primaryColor,
                  width: .65,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: maxLines == 1 ? 8 : 15),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: KColors.primaryColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red[700]!,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red[700]!,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: KColors.primaryColor,
                  width: .65,
                ),
              ),
            ),
      ),
    );
  }
}
