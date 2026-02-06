import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants/k_colors.dart';
import '/utils/constants/k_styles.dart';
import '/utils/enums/button_state.dart';

class WitScaffoldFetching extends StatelessWidget {
  const WitScaffoldFetching({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: 100.w,
      child: const Center(
        child: WitFetching(),
      ),
    );
  }
}

class WitScaffoldError extends StatelessWidget {
  final String error;
  const WitScaffoldError({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error,
                style: Kstyles.kHintStyle.copyWith(
                  color: KColors.primaryColor,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WitFetching extends StatelessWidget {
  final Color? color;
  final double? size;
  const WitFetching({
    this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: color ?? KColors.primaryColor,
        size: size ?? 60,
      ),
    );
  }
}

class WitTextFetching extends StatelessWidget {
  final Color? color;
  final double? size;
  const WitTextFetching({
    this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? KColors.primaryColor,
      size: size ?? 20,
    );
  }
}

class WitTextIndicationFetching extends StatelessWidget {
  final KButtonState buttonState;
  final Color? color;
  final double? size;
  const WitTextIndicationFetching({
    required this.buttonState,
    this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: buttonState == KButtonState.idle,
      replacement: Visibility(
        visible: buttonState == KButtonState.processing,
        replacement: Visibility(
          visible: buttonState == KButtonState.success,
          replacement: Center(
            child: Icon(
              Icons.error,
              color: color ?? KColors.errorColor,
              size: size ?? 30,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check_circle,
              color: color ?? KColors.switchColor,
              size: size ?? 30,
            ),
          ),
        ),
        child: Center(
          child: SpinKitThreeBounce(
            color: color ?? KColors.primaryColor,
            size: size ?? 30,
          ),
        ),
      ),
      child: const SizedBox(),
    );
  }
}

class WitIndicationFetching extends StatelessWidget {
  final KButtonState buttonState;
  final Color? color;
  final double? size;
  const WitIndicationFetching({
    required this.buttonState,
    this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: buttonState == KButtonState.idle,
      replacement: Visibility(
        visible: buttonState == KButtonState.processing,
        replacement: Visibility(
          visible: buttonState == KButtonState.success,
          replacement: Center(
            child: Icon(
              Icons.error,
              color: color ?? KColors.errorColor,
              size: size ?? 120,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check_circle,
              color: color ?? KColors.switchColor,
              size: size ?? 120,
            ),
          ),
        ),
        child: Center(
          child: SpinKitCircle(
            color: color ?? KColors.primaryColor,
            size: size ?? 120,
          ),
        ),
      ),
      child: const SizedBox(),
    );
  }
}

class NavigationClass {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}

// class Loading {
//   void indicator(BuildContext context) {
//     showDialog(
//       context: (context),
//       builder: (BuildContext context) => const Center(
//         child: SpinKitWave(
//           color: Colors.white,
//           size: 50.0,
//         ),
//       ),
//     );
//   }

//   static void witIndicator({String? title, String? subTitle}) {
//     showDialog(
//       context: NavigationClass.navigationKey.currentState!.overlay!.context,
//       builder: (context) => AlertDialog(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SpinKitCircle(color: Colors.white),
//             const Sbh(h: 5),
//             Text(
//               title ?? 'Loading',
//               style: Kstyles.kSmallTextStyle.copyWith(
//                 color: Colors.white,
//               ),
//             ),
//             const Sbh(h: 5),
//             Text(
//               subTitle ?? 'Please wait...',
//               style: Kstyles.kVerySmallTextStyle.copyWith(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         // ],
//       ),
//     );
//   }
// }
