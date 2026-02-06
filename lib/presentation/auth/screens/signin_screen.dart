import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '/components/buttons/k_button.dart';
import '/components/buttons/register_button.dart';
import '/components/sizing_box.dart';
import '/presentation/auth/notifier/auth_notifier.dart';
import '/utils/constants/k_assets.dart';
import '/utils/constants/k_colors.dart';
import '/utils/constants/k_routes.dart';
import '/utils/constants/k_styles.dart';
import '/utils/enums/button_state.dart';
import '/utils/responsive/responsive.dart';
import '/utils/responsive/responsive_wrapper.dart';
import '/utils/validators/login_validators.dart';
import '../../../components/textfields/login_textfield.dart';

class SignInScreen extends HookConsumerWidget {
  static const id = KRoutes.signInScreen;
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> authkey =
        useMemoized(() => GlobalKey<FormState>());

    TextEditingController password =
        useTextEditingController(text: kDebugMode ? "string" : "");
    TextEditingController email =
        useTextEditingController(text: kDebugMode ? "mayank@gmail.com" : "");
    ValueNotifier<bool> isLoading = useState(false);
    ValueNotifier<bool> rememberme = useState(false);
    ValueNotifier<bool> obsecure = useState(true);

    useEffect(() {
      ref
          .read(authNotifierProvider)
          .fetchRememberEmail(email: email, pass: password);
      return null;
    }, []);

    return Scaffold(
      body: Form(
        key: authkey,
        child: ResponsiveWrapper(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 100.h -
                  (Platform.isAndroid ? 1 : 1.3) *
                      AppBar().preferredSize.height,
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        KAssets.splashIcon,
                        height: 100,
                        colorFilter: ColorFilter.mode(
                          KColors.blackColor,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
                  // AuthHeader(
                  //   welcomemessage: ref.watch(authProvider).welcomeMessage,
                  // ),
                  const Sbh(h: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    margin: const EdgeInsets.all(12),
                    width: Responsive.isMobile(context) ? double.infinity : 490,
                    decoration: BoxDecoration(
                      color: KColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1.6,
                        color: KColors.primaryColor.withValues(
                          alpha: .2,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Id",
                          style: Kstyles.kSubHeadingStyle.copyWith(
                            color: KColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width:
                              Responsive.isMobile(context) ? (100.w - 60) : 450,
                          child: LoginTextfield(
                            controller: email,
                            hintText: "Enter Email",
                            prefixIcon: IconlyBold.message,
                            validator: (v) => LoginValidators.emailValidator(v),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const Sbh(h: 20),
                        Text(
                          "Password",
                          style: Kstyles.kSubHeadingStyle.copyWith(
                            color: KColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width:
                              Responsive.isMobile(context) ? (100.w - 60) : 450,
                          child: LoginTextfield(
                            suffixIcon: !obsecure.value
                                ? IconlyLight.show
                                : IconlyLight.hide,
                            onSuffixTap: () => obsecure.value = !obsecure.value,
                            validator: (v) =>
                                LoginValidators.passwordValidator(v),
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: IconlyBold.lock,
                            hintText: "Enter Password",
                            obsecure: obsecure.value,
                            controller: password,
                            // focus: FocusNode(),
                          ),
                        ),
                        const Sbh(h: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                rememberme.value = !rememberme.value;
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Checkbox(
                                      value: rememberme.value,
                                      activeColor: KColors.primaryColor,
                                      onChanged: (v) {
                                        rememberme.value = !rememberme.value;
                                      },
                                      side: const BorderSide(
                                        color: KColors.primaryColor,
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const Sbw(w: 4),
                                  Text(
                                    "Remember",
                                    style: Kstyles.kHintStyle.copyWith(
                                      color: KColors.primaryColor,
                                      fontSize: Responsive.isMobile(context)
                                          ? 15.sp
                                          : 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Sbh(h: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KButton(
                              buttonCorner: KButtonCorner.mid,
                              label: "Login",
                              labelSize: 16.5,
                              buttonState: isLoading.value
                                  ? KButtonState.processing
                                  : KButtonState.idle,
                              width: Responsive.isMobile(context)
                                  ? (100.w - 60)
                                  : 450,
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (authkey.currentState!.validate()) {
                                  if (!isLoading.value) {
                                    isLoading.value = true;
                                    await ref
                                        .read(authNotifierProvider)
                                        .signInWithEmailPassword(
                                          rememberme: rememberme.value,
                                          password: password.text,
                                          email: email.text,
                                        );
                                    isLoading.value = false;
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        const Sbh(h: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                // ref.read(routingService)
                                //     .push(KRoutes.forgotPassword);
                              },
                              child: Text(
                                "Forgot Password",
                                style: Kstyles.kHintStyle.copyWith(
                                  color: KColors.primaryColor,
                                  fontSize: Responsive.isMobile(context)
                                      ? 15.sp
                                      : 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 350),
                  const Sbh(h: 8),
                  Text(
                    "New to EzySky ? ",
                    style: Kstyles.kHintStyle.copyWith(
                      color: KColors.primaryColor,
                      fontSize: Responsive.isMobile(context) ? 18.sp : 15.sp,
                    ),
                  ),
                  const Sbh(h: 8),
                  RegisterButton(
                    onPressed: () async {
                      // ref.read(routingService).push(KRoutes.signUpScreen);
                    },
                  ),
                  const Spacer(flex: 2),
                  /* const Spacer(flex: 2),
                  Visibility(
                    visible: (ref.watch(authProvider).packageInfo?.version ?? '')
                        .isNotEmpty,
                    child: Padding(
                      // color: KColors.whiteColor,
                      padding: EdgeInsets.only(
                        bottom: Platform.isAndroid ? 8 : 20.sp,
                        top: 8,
                      ),
                      child: Text(
                        "Intelligere v${(ref.watch(authProvider).packageInfo?.version ?? '')}",
                        style: Kstyles.kHintStyle.copyWith(
                          // color: KColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
