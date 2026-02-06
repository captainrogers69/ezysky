import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:squareboat/services/dialog_service.dart';

import '../services/image_service.dart';
import '../services/routing_service.dart';
import '../utils/themes/k_theme.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(fastCacheImageServiceProvider).init();
      return null;
    }, []);

    return Sizer(
      builder: (p1, p2, p3) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            scaffoldMessengerKey: ref.read(snackKeyProvider),
            routerConfig: ref.read(routingService),
            debugShowCheckedModeBanner: false,
            darkTheme: KTheme.lightTheme,
            themeMode: ThemeMode.system,
            theme: KTheme.lightTheme,
            title: 'EzySky',
          ),
        );
      },
    );
  }
}

/// This Provider returns the [GlobalKey<ScaffoldMessengerState>] which can display the snackbar/toast

/// Use this [currentState?.showSnackBar(SnackBar(content: Text("Snackbar Display"));]
final snackKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>((ref) {
  return DialogService.snackBarKey;
});
