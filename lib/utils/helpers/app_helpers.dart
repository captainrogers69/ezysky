import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:squareboat/services/dialog_service.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';

final kHelpersProvider = Provider<KHelpers>((ref) {
  return KHelpers(/* ref */);
});

class KHelpers {
  // final Ref _ref;
  KHelpers(/* this._ref */);

  static void showSnackBar({required String message, bool error = false}) {
    DialogService.snackBarKey.currentState?.showSnackBar(
      _snackbarcontent(
        error: error,
        message,
      ),
    );
  }

  static SnackBar _snackbarcontent(String message, {bool error = false}) {
    return SnackBar(
      duration: const Duration(milliseconds: 1200),
      backgroundColor: error ? KColors.darkErrorColor : KColors.primaryColor,
      content: Text(
        message,
        style: Kstyles.kButtonStyle.copyWith(
          color: KColors.whiteColor,
        ),
      ),
    );
  }

  final List<BoxShadow> witBoxShadow = [
    const BoxShadow(
      offset: Offset(2, 2),
      blurRadius: 12,
      color: Color.fromRGBO(0, 0, 0, 0.16),
    )
  ];

  static final List<BoxShadow> witBoxShadowstatic = [
    const BoxShadow(
      offset: Offset(2, 2),
      blurRadius: 12,
      color: Color.fromRGBO(0, 0, 0, 0.16),
    )
  ];

  final List<BoxShadow> darkShadow = [
    BoxShadow(
      offset: const Offset(2, 2),
      blurRadius: 12,
      color: Colors.grey[400]!,
    )
  ];

  final List<BoxShadow> lightShadow = [
    const BoxShadow(
      offset: Offset(1, 1),
      blurRadius: 12,
      color: Color.fromRGBO(0, 0, 0, 0.16),
    )
  ];

  final List<BoxShadow> topShadow = [
    BoxShadow(
      offset: Offset(-12, -12),
      blurRadius: 12,
      color: Color.fromRGBO(0, 0, 0, 0.16),
    )
  ];

  final Border bororder = Border.all(color: Colors.black, width: 1.5);
  final Border smallBorder = Border.all(color: Colors.blue);

  final BorderRadius witRadiusSmall = BorderRadius.circular(5);
  final BorderRadius witRadiusSmalling = BorderRadius.circular(8);
  final BorderRadius witRadiusStan = BorderRadius.circular(11);
  final BorderRadius witRadiusMid = BorderRadius.circular(21);
  final BorderRadius witRadiusCircular = BorderRadius.circular(81);

  final BorderRadius witSmallShape = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
  );

  final BorderRadius witRoundedShape = BorderRadius.only(
    topLeft: Radius.circular(11),
    topRight: Radius.circular(11),
  );

  final ShapeBorder roundedShapeSmall = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    ),
  );

  final ShapeBorder roundedDialogShapeStan = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(11),
  );

  final ShapeBorder roundedShapeStan = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(11),
      topRight: Radius.circular(11),
    ),
  );

  final ShapeBorder roundedShapeMid = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(21),
      topRight: Radius.circular(21),
    ),
  );

  final EdgeInsets marginSymmetric =
      EdgeInsets.symmetric(vertical: 10, horizontal: 15);
}
