import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/data/models/user_model.dart';
import '/services/auth_service.dart';
import '/services/routing_service.dart';
import '/services/secure_storage_service.dart';
import '/utils/constants/k_routes.dart';

final authNotifierProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier(ref);
});

abstract class BaseAuthNotifier {
  Future<void> fetchRememberEmail(
      {required TextEditingController email,
      required TextEditingController pass});
  Future<void> signInWithEmailPassword(
      {required String email,
      required String password,
      required bool rememberme});
  Future<void> logout();
  Future<void> checkAppVersion();
  Future<void> fetchCurrentUser();
}

class AuthNotifier extends ChangeNotifier implements BaseAuthNotifier {
  final Ref _ref;
  AuthNotifier(this._ref);

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void _configCurrentUser({required UserModel? state}) {
    _currentUser = state;
    SchedulerBinding.instance.addPostFrameCallback((e) {
      notifyListeners();
    });
  }

  DateTime? _clockedTime;
  DateTime? get clockedTime => _clockedTime;

  void configClockedTime({required DateTime? state}) {
    _clockedTime = state;
    SchedulerBinding.instance.addPostFrameCallback((e) {
      notifyListeners();
    });
  }

  @override
  Future<void> fetchRememberEmail(
      {required TextEditingController email,
      required TextEditingController pass}) async {
    (String, String) res =
        await _ref.read(authServiceProvider).fetchOrSaveRememberMeDetails();
    if (res.$1.isNotEmpty) {
      email.text = res.$1;
      pass.text = res.$2;
    }
  }

  @override
  Future<void> signInWithEmailPassword(
      {required String email,
      required String password,
      required bool rememberme}) async {
    try {
      final Map<String, dynamic> fetchedUser = await _ref
          .read(authServiceProvider)
          .signInWithEmailPassword(email: email, password: password);

      log("signInWithEmailPassword: Fetch User- $fetchedUser",
          name: "AuthNotifer");
      if (fetchedUser.isNotEmpty) {
        if (rememberme) {
          _ref
              .read(authServiceProvider)
              .fetchOrSaveRememberMeDetails(email: email, password: password);
        }
        UserModel user = UserModel.fromJson(fetchedUser);
        _configCurrentUser(state: user);
        configClockedTime(state: DateTime.now());
        _ref
            .read(routingService)
            .pushReplacement(KRoutes.homeScreen, extra: "sign_in");
      } else {
        // _ref
        //     .read(kHelpersProvider)
        //     .showSnackBar(message: "Something went wrong", error: true);
      }
    } catch (e) {
      log("signInWithEmailPassword - catch $e", name: "AuthNotifer");
      // _ref
      //     .read(kHelpersProvider)
      //     .showSnackBar(message: "Something went wrong", error: true);
    }
  }

  @override
  Future<void> logout() async {
    _ref.read(localStorageServiceProvider).clear(Keys.userId);
    _ref.read(routingService).go(KRoutes.signInScreen);
    _configCurrentUser(state: null);
  }

  @override
  Future<void> fetchCurrentUser() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () async {
        /* String currentUser =
            await _ref.read(authServiceProvider).fetchCurrentUser();
        log("fetchCurrentUser: $currentUser", name: "AuthNotifier");

        /// [fetch user data here]
        if (currentUser.isNotEmpty) {
          Map<String, dynamic> decoded = jsonDecode(currentUser) ?? {};
          UserModel user = UserModel.fromJson(decoded);
          _configCurrentUser(state: user);
          configClockedTime(state: DateTime.now());
          // await _ref.read(remoteConfigServiceProvider).checkforRestriction();
          await checkAppVersion();
          _ref.read(routingService).pushReplacement(KRoutes.homeScreen);
        } else {
          _ref
              .read(routingService)
              .pushReplacement(KRoutes.signInScreen, extra: false);
        } */

        _ref.read(routingService).pushReplacement(KRoutes.homeScreen);
      },
    );
  }

  // PackageInfo here
  PackageInfo? _packageInfo;
  PackageInfo? get packageInfo => _packageInfo;

  @override
  Future<void> checkAppVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    SchedulerBinding.instance.addPostFrameCallback((e) {
      notifyListeners();
    });
  }
}
