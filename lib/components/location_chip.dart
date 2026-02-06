import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:squareboat/components/address_suggestions.dart';
import 'package:squareboat/components/app_textfield.dart';
import 'package:squareboat/utils/constants/k_colors.dart';
import 'package:squareboat/utils/helpers/app_helpers.dart';

class LocationPickerWidget extends HookWidget {
  const LocationPickerWidget({
    super.key,
    this.label,
    required this.textEditingController,
    required this.selectedLocations,
    required this.onLocationAdded,
    required this.onLocationRemoved,
    this.onTextChanged,
    this.hintText,
    this.isRequired = false,
    this.maxSelections,
    this.labelStyle,
    this.fieldStyle,
    this.hintStyle,
    this.errorStyle,
    this.fillColor,
    this.borderColor,
    this.contentPadding,
    this.borderRadius = 10,
    this.hideErrorText = false,
    this.isEnabled = true,
    this.googleMapsApiKey,
    this.chipSpacing = 4,
    this.chipRunSpacing = 4,
    this.vs = 4,
  });

  final String? label;
  final TextEditingController textEditingController;
  final List<String> selectedLocations;
  final Function(String location) onLocationAdded;
  final Function(int index) onLocationRemoved;
  final Function(String text)? onTextChanged;
  final String? hintText;
  final bool isRequired;
  final int? maxSelections;
  final TextStyle? labelStyle;
  final TextStyle? fieldStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool hideErrorText;
  final bool isEnabled;
  final String? googleMapsApiKey;
  final double chipSpacing;
  final double chipRunSpacing;
  final double vs;
  // Google Maps API Key - use provided or default
  static const String _defaultGoogleMapsApiKey =
      'AIzaSyC1U6s_cNHlar4BQQP17PDbwx93m8kRkp4';

  @override
  Widget build(BuildContext context) {
    // final appSize = AppSize.fromSize(context);
    final effectiveLabelStyle = labelStyle;
    final effectiveFieldStyle = fieldStyle;
    final effectiveHintStyle = hintStyle ?? (fieldStyle);
    final effectiveContentPadding = contentPadding ??
        const EdgeInsets.only(left: 16, right: 12, top: 14, bottom: 14);
    final fieldFocusNode = useFocusNode();
    final suggestions = useState<List<dynamic>>([]);
    final showSuggestions = useState<bool>(false);
    final isLoading = useState<bool>(false);
    final hasInteracted = useState<bool>(false);
    final dio = useMemoized(() => Dio());
    final apiKey = googleMapsApiKey ?? _defaultGoogleMapsApiKey;
    final debounce = useRef<Timer?>(null);

    useEffect(() {
      return () {
        debounce.value?.cancel();
      };
    }, []);

    // Fetch suggestions from API
    Future<void> fetchSuggestions(String text) async {
      if (text.isEmpty) {
        suggestions.value = [];
        showSuggestions.value = false;
        return;
      }

      if (maxSelections != null && selectedLocations.length >= maxSelections!) {
        showSuggestions.value = false;
        return;
      }

      try {
        isLoading.value = true;
        final response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json',
          queryParameters: {
            'input': text,
            'key': apiKey,
          },
        );

        if (response.statusCode == 200) {
          suggestions.value = response.data['predictions'] ?? [];
          showSuggestions.value = suggestions.value.isNotEmpty;
        } else {
          log('Failed to load suggestions: ${response.data}',
              name: "AppLabelLocationPicker");
          suggestions.value = [];
          showSuggestions.value = false;
        }
      } catch (e) {
        log('Error fetching place suggestions: $e',
            name: "AppLabelLocationPicker");
        suggestions.value = [];
        showSuggestions.value = false;
      } finally {
        isLoading.value = false;
      }
    }

    // Handle text changes with debounce
    void handleTextChanged(String text) {
      hasInteracted.value = true;
      onTextChanged?.call(text);

      // Cancel previous timer
      debounce.value?.cancel();

      // If text is empty, clear suggestions immediately
      if (text.isEmpty) {
        suggestions.value = [];
        showSuggestions.value = false;
        return;
      }

      // Set new timer to fetch suggestions after 300ms of no typing
      debounce.value = Timer(const Duration(milliseconds: 300), () {
        fetchSuggestions(text);
      });
    }

    // Handle suggestion selection
    void handleSuggestionTap(String placeId) async {
      try {
        isLoading.value = true;
        final response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/details/json',
          queryParameters: {
            'place_id': placeId,
            'key': apiKey,
          },
        );

        if (response.statusCode == 200) {
          final result = response.data['result'];
          final description = result['formatted_address'] as String? ??
              result['name'] as String? ??
              '';

          if (description.isNotEmpty) {
            // Check max selections
            if (maxSelections != null &&
                selectedLocations.length >= maxSelections!) {
              // Show error message
              KHelpers.showSnackBar(
                  message:
                      'Maximum $maxSelections location${maxSelections! > 1 ? 's' : ''} allowed',
                  error: true);
            } else if (!selectedLocations.contains(description)) {
              onLocationAdded(description);
              textEditingController.clear();
              showSuggestions.value = false;
              suggestions.value = [];
            }
          }
        }
      } catch (e) {
        log('Error fetching place details: $e', name: "AppLabelLocationPicker");
      } finally {
        isLoading.value = false;
      }
    }

    // Build suffix icon (loading or search icon)
    Widget buildSuffixIcon() {
      if (isLoading.value) {
        return SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                KColors.grey700,
              ),
            ),
          ),
        );
      }
      return Icon(
        Icons.search,
        color: isEnabled &&
                (maxSelections == null ||
                    selectedLocations.length < maxSelections!)
            ? KColors.grey700
            : KColors.grey500,
        size: 24,
      );
    }

    // Validator function for location validation
    String? validateLocations(String? value) {
      // Only validate after user interaction
      // if (!hasInteracted.value) {
      //   return null;
      // }

      // Check if required and no locations selected
      if (isRequired && selectedLocations.isEmpty) {
        return "At least one location is required.";
      }

      // Check if max selections exceeded
      // if (maxSelections != null && selectedLocations.length > maxSelections!) {
      //   return "Maximum $maxSelections location${maxSelections! > 1 ? 's' : ''} allowed.";
      // }

      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          textEditingController: textEditingController,
          label: label,
          hintText: hintText ?? "Choose location",
          isRequired: isRequired,
          vs: vs,
          labelStyle: effectiveLabelStyle,
          fieldStyle: effectiveFieldStyle,
          hintStyle: effectiveHintStyle,
          fillColor: fillColor ?? KColors.whiteColor,
          contentPadding: effectiveContentPadding,
          borderRadius: borderRadius,
          isEnabled: isEnabled &&
              (maxSelections == null ||
                  selectedLocations.length < maxSelections!),
          suffixIcon: buildSuffixIcon(),
          onChangeFunction: handleTextChanged,
          validatorFunction: validateLocations,
          onEditingComplete: () {
            hasInteracted.value = true;
            if (textEditingController.text.trim().isNotEmpty) {
              final text = textEditingController.text.trim();
              if (maxSelections == null ||
                  selectedLocations.length < maxSelections!) {
                if (!selectedLocations.contains(text)) {
                  onLocationAdded(text);
                  textEditingController.clear();
                }
              }
              showSuggestions.value = false;
              fieldFocusNode.unfocus();
            }
          },
          onTap: () {
            hasInteracted.value = true;
          },
          focusNode: fieldFocusNode,
          hideErrorText: hideErrorText,
        ),
        // Suggestions dropdown
        if (showSuggestions.value && suggestions.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: AddressSuggestionsWidget(
              suggestions: suggestions.value,
              onSuggestionTap: handleSuggestionTap,
            ),
          ),
        // Selected locations as chips
        if (selectedLocations.isNotEmpty) ...[
          // appSize.s8to12.vs,
          Wrap(
            spacing: chipSpacing,
            runSpacing: chipRunSpacing,
            children: selectedLocations.asMap().entries.map((entry) {
              return LocationChipWidget(
                location: entry.value,
                onRemove: () {
                  onLocationRemoved(entry.key);
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class LocationChipWidget extends StatelessWidget {
  final String location;
  final VoidCallback onRemove;

  const LocationChipWidget({
    super.key,
    required this.location,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(location),
      backgroundColor: KColors.grey200,
      deleteIcon: Icon(
        Icons.delete,
        // height: 16,
        // width: 16,
      ),
      onDeleted: onRemove,
      labelStyle: TextStyle(
        color: KColors.blackColor,
        fontSize: 12,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}
