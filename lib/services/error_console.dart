import 'dart:developer';

import 'package:flutter/foundation.dart';

class ErrorConsole {
  static void dumpCrashlyticsData() {
    try {
      FlutterError.onError = (errorDetails) {
        // eliminating the junk image data
        if (errorDetails.library == 'image resource service') {
          return;
        }

        /// [Record the filtered crash data in crashlytics]
        // FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        /// [Record the filtered crash data in crashlytics]
        // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      FlutterError.onError = (FlutterErrorDetails details) async {
        FlutterError.dumpErrorToConsole(details);
        log("dumpErrorToConsole: ${details.exceptionAsString()}",
            name: "Error Console");

        /// [Display the error separately]
        /* runApp(ErrorConsole(details: details));
          final container = ProviderContainer();
          await container.read(dialogProvider).openDialog(
            dialog: KAlertDialog(
              subtitle: details.exceptionAsString(),
              actions: const [], title: "Error",
              onAction: () {}, onCancel: () {},
            ),
          ); */
      };
    } catch (e) {
      log("catch: $e", name: "Error Console");
    }
  }
}

/* class ErrorConsoleDisplay extends StatelessWidget {
  final FlutterErrorDetails details;
  const ErrorConsoleDisplay({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Error",
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: const WitAppBar(title: "Error"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyLight.info_circle,
              color: KColors.darkErrorColor,
              size: 30,
            ),
            const Sbh(h: 15),
            Text(
              "Error Occurred!",
              style: Kstyles.kHintStyle.copyWith(
                color: KColors.blackColor,
              ),
            ),
            const Sbh(h: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                details.exceptionAsString(),
                style: Kstyles.kButtonStyle.copyWith(
                  color: KColors.grey700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */
