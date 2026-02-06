import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/my_app.dart';
import 'services/error_console.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [optional if i want to lock the orientation]
  /* SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */

  if (!kDebugMode) {
    ErrorConsole.dumpCrashlyticsData();
  }
  if (kDebugMode) {
    runApp(
      const Banner(
        /// [Handle Dev/Stagging tag here for internal Releases]
        message: "Debug",
        textDirection: TextDirection.ltr,
        location: BannerLocation.topEnd,
        layoutDirection: TextDirection.ltr,
        child: ProviderScope(
          child: MyApp(),
        ),
      ),
    );
  } else {
    runApp(
      ProviderScope(
        child: const MyApp(),
      ),
    );
  }
}
