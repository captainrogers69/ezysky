import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:squareboat/utils/constants/k_colors.dart';

/// A reusable widget for displaying address autocomplete suggestions
///
/// This widget displays a list of address suggestions from Google Places API
/// with proper styling according to the app's design system.
class AddressSuggestionsWidget extends StatelessWidget {
  const AddressSuggestionsWidget({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
    this.maxHeight = 250,
    this.margin = const EdgeInsets.only(top: 0),
  });

  /// List of suggestion items from Google Places API
  /// Each item should be a Map with 'description' and 'place_id' keys
  final List<dynamic> suggestions;

  /// Callback when a suggestion is tapped
  /// Receives the place_id as a parameter
  final Function(String placeId) onSuggestionTap;

  /// Maximum height of the suggestions container
  final double maxHeight;

  /// Margin around the suggestions container
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    // final AppSize appSize = AppSize.fromSize(context);

    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: KColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: KColors.blackColor.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: KColors.grey400,
          width: 1,
        ),
      ),
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          thickness: 0.5,
          color: KColors.grey400,
        ),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final description = suggestion['description'] as String? ?? '';
          final placeId = suggestion['place_id'] as String?;

          if (placeId == null) {
            log('Place ID is null for suggestion at index $index');
            return const SizedBox.shrink();
          }

          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              onSuggestionTap(placeId);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  // horizontal: appSize.s16to24,
                  // vertical: appSize.s12to16,
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: KColors.grey600,
                    size: 20,
                  ),
                  // SizedBox(width: appSize.s12to16),
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // style: appSize.tsStoP.copyWith(
                      //   color: KColors.grey13,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Address details result for UI consumption
class AddressDetails {
  final String addressLine1;
  final String addressLine2;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  const AddressDetails({
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
  });
}
