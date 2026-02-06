// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:squareboat/components/buttons/k_button.dart';
import 'package:squareboat/components/screen_wrapper.dart';
import 'package:squareboat/data/models/whether_model.dart';
import 'package:squareboat/presentation/home/notifier/home_notifier.dart';
import 'package:squareboat/presentation/home/widgets/city_finder_sheet.dart';
import 'package:squareboat/presentation/home/widgets/whether_city_card.dart';
import 'package:squareboat/services/dialog_service.dart';
import 'package:squareboat/utils/constants/k_colors.dart';
import 'package:squareboat/utils/enums/button_state.dart';

import '/components/appbars/wit_appbar.dart';
import '/utils/constants/k_routes.dart';

class HomeScreen extends HookConsumerWidget {
  static const id = KRoutes.homeScreen;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scroll = useScrollController();

    useEffect(() {
      // WidgetsBinding.instance.addPostFrameCallback((e) {
      //   ref.read(dialogServiceProvider).openSheet(dialog: CityFinderSheet());
      // });
      return null;
    }, []);

    WhetherResponse? whetherdata =
        ref.watch(homeWhetherNotifier).cityWhetherResponse;

    return Scaffold(
      appBar: WitAppBar(
        shouldBack: false,
        // leading: SizedBox.shrink(),
        title: "Hi User",
      ),
      body: RefreshIndicator(
        color: KColors.primaryColor,
        onRefresh: () async {
          //TODO: refresh here
        },
        child: RawScrollbar(
          thumbColor: KColors.grey600,
          controller: scroll,
          child: CustomScrollView(
            controller: scroll,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: ScreenWrapper(
                  emptyMessage: "",
                  isFetching: ref.watch(homeWhetherNotifier).fetchingWhether,
                  isEmpty: false,
                  child: TravelWeatherCard(
                    data: whetherdata,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: KButton(
                    label: ref.watch(homeWhetherNotifier).cityWhetherResponse ==
                            null
                        ? "Check Whether"
                        : "Change City",
                    onTap: () {
                      ref
                          .read(dialogServiceProvider)
                          .openSheet(dialog: CityFinderSheet());
                    },
                    width: 90.w,
                    buttonCorner: KButtonCorner.mid,
                    labelSize: 14,
                    buttonColor: KColors.primaryColor,
                    buttonState: KButtonState.idle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
