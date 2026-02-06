import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:squareboat/components/buttons/k_button.dart';
import 'package:squareboat/components/drag_handle.dart';
import 'package:squareboat/components/heading_h.dart';
import 'package:squareboat/components/search_location.dart';
import 'package:squareboat/presentation/home/notifier/home_notifier.dart';
import 'package:squareboat/utils/constants/k_colors.dart';
import 'package:squareboat/utils/enums/button_state.dart';

class CityFinderSheet extends HookConsumerWidget {
  const CityFinderSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController locationSearch = useTextEditingController();
    ValueNotifier<Position?> selectedLocations = useState(null);
    ValueNotifier<List<String>> selectedFormattedLocations = useState([]);
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DragHandle(),
            KHomeHeading(
              title: "Tell us where you want to visit",
              trailing: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                ),
              ),
            ),
            LocationPickerWidget(
              textEditingController: locationSearch,
              selectedLocations: selectedFormattedLocations.value.toList(),
              onLocationAdded: (dataLocation, formatted) {
                log("here is the result we needed $dataLocation :: ${dataLocation.runtimeType}");
                Map<String, dynamic>? data =
                    Map<String, dynamic>.from(dataLocation ?? {});
                Position local = Position(
                  longitude: data['location']?['lng'] ?? 0,
                  latitude: data['location']?['lat'] ?? 0,
                  timestamp: DateTime.now(),
                  accuracy: 100,
                  altitude: 0,
                  altitudeAccuracy: 100,
                  heading: 0,
                  headingAccuracy: 100,
                  speed: 0,
                  speedAccuracy: 100,
                );
                selectedLocations.value = local;
                if (formatted.trim().isNotEmpty &&
                    !selectedFormattedLocations.value
                        .contains(formatted.trim())) {
                  selectedFormattedLocations.value = [
                    ...selectedFormattedLocations.value,
                    formatted.trim()
                  ];
                  locationSearch.clear();
                }
              },
              onLocationRemoved: (index) {
                // if (index < selectedLocations.value.length) {
                //   selectedLocations.value = [...selectedLocations.value]
                //     ..removeAt(index);
                // }
              },
              hintText: "Search City",
              // labelStyle: appSize.tsH6toH5.copyWith(fontWeight: semiBold),
              vs: 12,
              // fieldStyle: appSize.tsStoP,
              fillColor: Colors.white,
              // contentPadding: appSize.contentPadding,
              maxSelections: 1, // Set max selection limit
              isRequired: true,
            ),
            SizedBox(height: 15),
            KButton(
              label: "Start Visiting",
              onTap: () {
                if (selectedLocations.value != null) {
                  ref.read(homeWhetherNotifier).configuserLocation(
                      state: selectedLocations.value,
                      formattedAddress:
                          selectedFormattedLocations.value.firstOrNull ?? '');
                }
              },
              width: 90.w,
              buttonCorner: KButtonCorner.mid,
              labelSize: 14,
              buttonColor: KColors.primaryColor,
              buttonState: ref.watch(homeWhetherNotifier).fetchingWhether
                  ? KButtonState.processing
                  : KButtonState.idle,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
