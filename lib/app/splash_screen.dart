import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

import '/presentation/auth/notifier/auth_notifier.dart';
import '/utils/constants/k_assets.dart';
import '/utils/constants/k_colors.dart';
import '/utils/constants/k_routes.dart';
import '/utils/constants/k_styles.dart';

class SplashScreen extends HookConsumerWidget {
  static const id = KRoutes.splashScreen;
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<double> fontSize = useState(2);
    ValueNotifier<double> containerSize = useState(1.5);
    ValueNotifier<double> textOpacity = useState(0.0);
    ValueNotifier<double> containerOpacity = useState(0.0);

    AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 2));
    ValueNotifier<Animation<double>?> animation1 = useState(null);

    Future<void> splashTransition() async {
      // _controller = AnimationController(
      //     vsync: this, duration: const Duration(seconds: 2));
      animation1.value = Tween<double>(begin: 40, end: 20).animate(
          CurvedAnimation(
              parent: controller, curve: Curves.fastLinearToSlowEaseIn))
        ..addListener(() {
          textOpacity.value = 1.0;
        });
      controller.forward();
      Timer(const Duration(milliseconds: 700), () {
        fontSize.value = 1.06;
      });
      Timer(const Duration(milliseconds: 800), () async {
        containerSize.value = 2;
        containerOpacity.value = 1;
        await ref.read(authNotifierProvider).fetchCurrentUser();
      });
    }

    useEffect(() {
      splashTransition();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: KColors.whiteColor,
      body: SizedBox(
        height: 100.h,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: 100.h / fontSize.value),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: textOpacity.value,
                    child: Text(
                      "EzySky",
                      style: Kstyles.kSplashStyle.copyWith(
                        color: KColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100.h,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          opacity: containerOpacity.value,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: 100.w / containerSize.value,
                            width: 100.w / containerSize.value,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: KColors.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: SizedBox(
                                child: SvgPicture.asset(
                                  //TODO: change whetherappicon
                                  KAssets.splashIcon,
                                  height: 150,
                                  colorFilter: ColorFilter.mode(
                                    KColors.blackColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
