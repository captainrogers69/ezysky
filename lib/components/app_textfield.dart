// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:squareboat/components/app_tooltip.dart';
import 'package:squareboat/components/label_widget.dart';
import 'package:squareboat/utils/constants/k_colors.dart';

class AppTextField extends HookWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validatorFunction;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final bool isObscure;
  final bool isRequired;
  final bool isReadOnly;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final String? textFieldLabelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? labelStyle;
  final TextStyle? fieldStyle;
  final TextStyle? toolTipStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final int maxLines;
  final int minLines;
  final Color? fillColor;
  final Color? subTextColor;
  final double borderRadius;
  final double borderWidth;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChangeFunction;
  final InputDecoration? decoration;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool isEnabled;
  final String? label;
  final bool isHintItalic;
  final bool isPassword;
  final EdgeInsetsGeometry? contentPadding;
  final bool isNumOnly;
  final bool hideErrorText;
  final double vs;
  final bool showCounter;
  final AutovalidateMode? autoValidateMode;
  final FocusNode? focusNode;
  final String? tooltipText;
  final Widget? tooltipIcon;
  final bool showToolTipInLabel;
  final bool showInfo;
  final void Function()? onInfoTap;

  const AppTextField({
    super.key,
    required this.textEditingController,
    this.label,
    this.isRequired = false,
    this.labelStyle,
    this.fieldStyle,
    this.toolTipStyle,
    this.hintStyle,
    this.errorStyle,
    this.onEditingComplete,
    this.validatorFunction,
    this.onTap,
    this.onChangeFunction,
    this.inputFormatters,
    this.keyboardType,
    this.isObscure = false,
    this.isReadOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textFieldLabelText,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 500,
    this.decoration,
    this.fillColor = KColors.whiteColor,
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.subTextColor,
    this.isEnabled = true,
    this.isHintItalic = false,
    this.contentPadding,
    this.isPassword = false,
    this.isNumOnly = false,
    this.hintText,
    this.hideErrorText = false,
    this.showCounter = false,
    this.autoValidateMode = AutovalidateMode.onUnfocus,
    this.focusNode,
    this.tooltipText,
    this.tooltipIcon,
    this.showToolTipInLabel = false,
    this.vs = 4,
    this.textAlign = TextAlign.left,
    this.showInfo = false,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    // final appSize = AppSize.fromSize(context);

    // Use provided focus node or create one
    final internalFocusNode = useFocusNode();
    final effectiveFocusNode = focusNode ?? internalFocusNode;

    // Track focus state for visual feedback
    final isFocused = useState<bool>(false);

    // Track password visibility
    final obscureText = useState<bool>(isPassword ? true : isObscure);

    // // Sync focus state and trim on focus
    useEffect(() {
      void onFocusChange() {
        isFocused.value = effectiveFocusNode.hasFocus;
        if (effectiveFocusNode.hasFocus) {
          textEditingController.text = textEditingController.text.trim();
        }
      }

      effectiveFocusNode.addListener(onFocusChange);
      return () => effectiveFocusNode.removeListener(onFocusChange);
    }, [effectiveFocusNode, textEditingController]);

    // Build hint text with required marker
    final hintTextWithRequired =
        hintText != null && isRequired ? '$hintText*' : hintText;
    // Read focus state at top level using hook (triggers rebuild on focus change)
    final isFocus = useValueListenable(isFocused);

    // Determine effective styles with defaults
    final effectiveLabelStyle = labelStyle;
    final effectiveFieldStyle = fieldStyle;
    final effectiveToolTipStyle = toolTipStyle;
    final effectiveErrorStyle = errorStyle;
    // Hint style logic: hintStyle if provided, else fieldStyle if provided, else default
    final effectiveHintStyle =
        hintStyle ?? (fieldStyle?.copyWith(fontSize: 14.sp));

    return FormField<String>(
      initialValue: textEditingController.text,
      validator: (value) {
        String? error;
        final currentValue = (value ?? '').trim().isNotEmpty
            ? value!
            : textEditingController.text;
        if (currentValue.trim().isEmpty) {
          error = isRequired ? "This field is required." : null;
        } else {
          error = validatorFunction?.call(currentValue);
        }
        return error;
      },
      autovalidateMode: autoValidateMode,
      builder: (state) {
        final hasErrorValue = state.hasError;
        final errorText = state.errorText;
        return LabelWidget(
          vs: vs,
          isRequired: isRequired,
          label: label,
          labelStyle: effectiveLabelStyle,
          tooltipText: showToolTipInLabel ? tooltipText : null,
          tooltipIcon: showToolTipInLabel ? tooltipIcon : null,
          toolTipStyle: effectiveToolTipStyle,
          errorMessage: errorText,
          errorStyle: effectiveErrorStyle,
          hideErrorText: hideErrorText,
          child: TextField(
            focusNode: effectiveFocusNode,
            enabled: isEnabled,
            textInputAction: textInputAction ??
                (maxLines > 1 ? TextInputAction.newline : TextInputAction.next),
            maxLength: maxLength,
            textCapitalization: textCapitalization,
            controller: textEditingController,
            cursorColor: Colors.black,
            onEditingComplete: onEditingComplete,
            onChanged: (value) {
              // Update FormField state to trigger validation
              state.didChange(value);
              onChangeFunction?.call(value);
            },
            readOnly: isReadOnly,
            onTap: onTap,
            keyboardType: keyboardType ??
                (isNumOnly ? TextInputType.number : TextInputType.emailAddress),
            style: effectiveFieldStyle?.copyWith(
              color: !isEnabled ? KColors.grey600 : null,
            ),
            obscureText: obscureText.value,
            textAlign: textAlign,
            textAlignVertical: TextAlignVertical.center,
            enableInteractiveSelection: true,
            autocorrect: false,
            decoration: decoration ??
                InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: textFieldLabelText,
                  errorMaxLines: 5,
                  counterText: showCounter
                      ? '${textEditingController.text.length}/$maxLength'
                      : '',
                  hintText: hintTextWithRequired,
                  contentPadding: contentPadding ??
                      const EdgeInsets.only(
                        left: 16,
                        right: 12,
                        top: 12,
                        bottom: 12,
                      ),
                  suffixIconConstraints:
                      const BoxConstraints(minHeight: 20, minWidth: 20),
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 20, minWidth: 16),
                  hintStyle: effectiveHintStyle?.copyWith(
                    color: hasErrorValue ? KColors.errorColor : KColors.grey500,
                    fontStyle:
                        isHintItalic ? FontStyle.italic : FontStyle.normal,
                  ),
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  filled: true,
                  fillColor: hasErrorValue
                      ? KColors.errorColor
                          .withValues(alpha: 0.08) // Light red/pink background
                      : (fillColor ??
                          (isFocus ? Colors.white : Colors.grey[100])),
                  prefixIcon: prefixIcon,
                  suffixIcon: AppSuffixIcon(
                    isPassword: isPassword,
                    obscureTextNotifier: obscureText,
                    tooltipText: tooltipText,
                    tooltipIcon: tooltipIcon,
                    toolTipStyle: effectiveToolTipStyle,
                    customIcon: suffixIcon,
                    showToolTipInLabel: showToolTipInLabel,
                    showInfo: showInfo,
                    onInfoTap: onInfoTap,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: hasErrorValue
                          ? KColors.errorColor
                          : KColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          hasErrorValue ? KColors.errorColor : KColors.grey400,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: KColors.errorColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: KColors.grey400),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: KColors.errorColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  isDense: true,
                ),
            inputFormatters: [
              NoInitialSpaceInputFormatter(),
              FilteringTextInputFormatter.deny(RegExp(
                  '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
              ...inputFormatters ?? [],
              if (isNumOnly) FilteringTextInputFormatter.digitsOnly
            ],
            maxLines: isPassword ? 1 : maxLines,
            minLines: isPassword ? 1 : minLines,
          ),
        );
      },
    );
  }
}

class _IconPadding extends StatelessWidget {
  final Widget? iconWidget;

  const _IconPadding({this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return iconWidget == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 0, right: 12.0, bottom: 0),
            child: iconWidget,
          );
  }
}

class NoInitialSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}

class AppSuffixIcon extends StatelessWidget {
  final bool isPassword;
  final ValueNotifier<bool>? obscureTextNotifier;
  final String? tooltipText;
  final Widget? tooltipIcon;
  final TextStyle? toolTipStyle;
  final Widget? customIcon;
  final bool showToolTipInLabel;
  final bool showInfo;
  final void Function()? onInfoTap;

  const AppSuffixIcon({
    super.key,
    required this.isPassword,
    this.obscureTextNotifier,
    this.tooltipText,
    this.tooltipIcon,
    this.toolTipStyle,
    this.customIcon,
    required this.showToolTipInLabel,
    this.showInfo = false,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Tooltip (only if NOT shown in label and NOT password)
    if (tooltipText != null && !showToolTipInLabel && !isPassword) {
      return _IconPadding(
        iconWidget: AppTooltip(
          tooltipText: tooltipText,
          tooltipIcon: tooltipIcon,
          toolTipStyle: toolTipStyle,
          iconSize: 24,
        ),
      );
    }

    // 2. Password toggle
    if (isPassword && obscureTextNotifier != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: obscureTextNotifier!,
        builder: (context, isObscure, child) {
          return _IconPadding(
            iconWidget: InkWell(
              onTap: () {
                obscureTextNotifier!.value = !obscureTextNotifier!.value;
              },
              child: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: KColors.grey600,
              ),
            ),
          );
        },
      );
    }

    // 3. Info icon (when requested and no tooltip/password)
    if (showInfo) {
      return _IconPadding(
        iconWidget: InkWell(
          onTap: () => onInfoTap?.call(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: const Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.black,
          ),
        ),
      );
    }

    // 4. Custom icon (if provided)
    return _IconPadding(iconWidget: customIcon);
  }
}
