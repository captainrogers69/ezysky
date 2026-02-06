import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

class LoginTextfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData? prefixIcon, suffixIcon;
  final void Function()? onSuffixTap;
  final TextInputType keyboardType;
  final bool obsecure, enabled;
  final Widget? prefixWidget;
  // final FocusNode focus;
  final String hintText;
  const LoginTextfield({
    required this.keyboardType,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.obsecure = false,
    this.enabled = true,
    // required this.focus,
    this.prefixWidget,
    this.onSuffixTap,
    this.suffixIcon,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: KColors.grey50,
        // boxShadow: witBoxShadow,
      ),
      child: TextFormField(
        obscureText: obsecure,
        controller: controller,
        // focusNode: focus,
        validator: validator,
        enabled: enabled,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        textInputAction: TextInputAction.go,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusColor: Theme.of(context).scaffoldBackgroundColor,
          prefixIcon: Visibility(
            visible: prefixIcon != null,
            replacement: const SizedBox.shrink(),
            child: prefixWidget ??
                Icon(
                  prefixIcon,
                  color: KColors.primaryColor,
                ),
          ),
          suffixIcon: Visibility(
            visible: suffixIcon != null,
            replacement: const SizedBox.shrink(),
            child: IconButton(
              onPressed: onSuffixTap ?? () {},
              icon: Icon(
                suffixIcon,
                color: KColors.primaryColor,
              ),
            ),
          ),
          hintText: hintText,
          hintStyle: Kstyles.kHintStyle,
          errorStyle: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
            color: KColors.errorColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: KColors.grey500,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: KColors.grey500,
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
            borderSide: BorderSide(
              color: KColors.grey500,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
