import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../utils/helpers/app_helpers.dart';
import '../utils/responsive/responsive.dart';
import 'routing_service.dart';

// GlobalKey<ScaffoldState> drawerkey = GlobalKey<ScaffoldState>();

final dialogServiceProvider = Provider<DialogService>((ref) {
  return DialogService(ref);
});

class DialogService {
  final Ref _ref;
  DialogService(this._ref);

  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldState> drawerkey = GlobalKey<ScaffoldState>();
  static final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> openCupertinoSheet(
      {required Widget dialog, bool barrierDismissible = true}) async {
    showCupertinoModalPopup(
      context: _ref
          .read(routingService)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return dialog;
      },
    );
  }

  Future<void> openDialog(
      {required Widget dialog, bool barrierDismissible = true}) async {
    showDialog(
      context: _ref
          .read(routingService)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return dialog;
      },
    );
  }

  Future<void> openSheet(
      {required Widget dialog, bool barrierDismissible = true}) async {
    if (Responsive.isMobile(_ref
        .read(routingService)
        .configuration
        .navigatorKey
        .currentState!
        .overlay!
        .context)) {
      showModalBottomSheet(
        context: _ref
            .read(routingService)
            .configuration
            .navigatorKey
            .currentState!
            .overlay!
            .context,
        shape: _ref.read(kHelpersProvider).roundedShapeStan,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          return SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: true,
            child: dialog,
          );
        },
      );
    } else {
      showDialog(
        context: _ref
            .read(routingService)
            .configuration
            .navigatorKey
            .currentState!
            .overlay!
            .context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return Dialog(
            shape: _ref.read(kHelpersProvider).roundedDialogShapeStan,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 550,
              ),
              child: dialog,
            ),
          );
        },
      );
    }
  }

  Future<void> openConstraintsSheet(
      {required Widget dialog, double? constraints}) async {
    showModalBottomSheet(
      context: _ref
          .read(routingService)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      shape: _ref.read(kHelpersProvider).roundedShapeStan,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: constraints ?? 65.h,
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: dialog,
        );
      },
    );
  }
}
