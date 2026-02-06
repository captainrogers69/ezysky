import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class CheckboxField extends StatelessWidget {
  final void Function() onChanged;
  final String hintText, labelText;
  final bool selected, onlyleftpadding;
  const CheckboxField(
      {super.key,
      required this.onChanged,
      required this.labelText,
      required this.hintText,
      required this.selected,
      this.onlyleftpadding = false});

  @override
  Widget build(BuildContext context) {
    return EmptyTextfield(
      controller: TextEditingController(),
      onlyleftpadding: onlyleftpadding,
      hintText: hintText,
      labelText: labelText,
      onTap: () {
        onChanged();
      },
      suffix: Checkbox(
        side: BorderSide(
          color: KColors.grey600,
          width: 1.3,
        ),
        activeColor: KColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        value: selected,
        onChanged: (value) {
          onChanged();
        },
      ),
    );
  }
}

class CheckBoxWithoutTile extends StatelessWidget {
  final void Function() onChanged;
  final bool selected;
  const CheckBoxWithoutTile({
    required this.onChanged,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          side: BorderSide(
            color: KColors.grey800,
            width: 1.65,
          ),
          activeColor: KColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          value: selected,
          onChanged: (value) {
            onChanged();
          },
        ),
      ],
    );
  }
}

class CheckBoxTile extends StatelessWidget {
  final void Function() onChanged;
  final String hintText;
  final bool selected;
  const CheckBoxTile(
      {required this.onChanged,
      required this.hintText,
      required this.selected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      splashColor: KColors.transparentColor,
      highlightColor: KColors.transparentColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            side: BorderSide(
              color: KColors.grey800,
              width: 1.65,
            ),
            activeColor: KColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            value: selected,
            onChanged: (value) {
              onChanged();
            },
          ),
          hintText != ''
              ? Text(
                  hintText,
                  style: Kstyles.kSmallTextStyle.copyWith(
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                    color: KColors.primaryColor,
                    fontSize: 15,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class EmptyTextfield extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final AutovalidateMode autoValidate;
  final String hintText, labelText;
  final TextCapitalization txtCapital;
  final TextInputType? keyBoardType;
  final int? maxLength, maxLines;
  final Widget? suffix, prefix;
  final void Function() onTap;
  final bool onlyleftpadding;
  final Widget? ledgerRemover;
  final bool isDropdown;
  const EmptyTextfield(
      {this.txtCapital = TextCapitalization.none,
      this.autoValidate = AutovalidateMode.onUnfocus,
      required this.labelText,
      this.ledgerRemover,
      this.onlyleftpadding = false,
      required this.controller,
      this.isDropdown = false,
      required this.hintText,
      this.inputFormatters,
      required this.onTap,
      this.maxLines = 1,
      this.keyBoardType,
      this.maxLength,
      this.validator,
      this.onChanged,
      this.suffix,
      this.prefix,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          splashColor: KColors.transparentColor,
          highlightColor: KColors.transparentColor,
          child: Container(
            // decoration: BoxDecoration(
            //   boxShadow: witBoxShadow,
            //   color: whiteColor,
            // ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                .copyWith(
              right: onlyleftpadding ? 0 : 12,
              left: 12,
            ),
            // padding: const EdgeInsets.all(5),
            child: TextFormField(
              enabled: false,
              textCapitalization: txtCapital,
              maxLines: maxLines,
              controller: controller,
              onChanged: onChanged,
              validator: validator ??
                  (val) {
                    return null;
                  },
              autovalidateMode: autoValidate,
              inputFormatters: inputFormatters,
              keyboardType: keyBoardType,
              maxLength: maxLength,
              style: Kstyles.kSmallTextStyle.copyWith(
                color: KColors.grey800,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                suffixIcon: suffix ??
                    Icon(
                      Icons.arrow_forward_ios,
                      color: KColors.grey600,
                      size: 15,
                    ),
                prefixIcon: prefix,
                hintStyle: Kstyles.kHintStyle.copyWith(
                  color: KColors.grey800,
                  fontSize: 16,
                ),
                labelText: labelText,
                labelStyle: Kstyles.kHintStyle.copyWith(
                  color: KColors.primaryColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: isDropdown
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: KColors.grey500,
                          width: 1,
                        ),
                      ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10).copyWith(
                  top: maxLines == 1 ? 0 : 15,
                ),
                focusedBorder: isDropdown
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: KColors.grey500,
                          width: 1,
                        ),
                      ),
                focusedErrorBorder: isDropdown
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: KColors.grey500,
                          width: 1,
                        ),
                      ),
                errorBorder: isDropdown
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: KColors.errorColor,
                          width: 1,
                        ),
                      ),
                disabledBorder: isDropdown
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: KColors.primaryColor,
                          width: .65,
                        ),
                      ),
              ),
            ),
          ),
        ),
        ledgerRemover == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                    .copyWith(
                  right: onlyleftpadding ? 0 : 12,
                  left: 12,
                ),
                child: ledgerRemover ?? const SizedBox(),
              ),
      ],
    );
  }
}
