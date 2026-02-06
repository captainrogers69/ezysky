import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/utils/constants/k_assets.dart';
import 'secure_storage_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

class AuthService {
  final Ref _ref;
  AuthService(this._ref);

  Future<Map<String, dynamic>> signInWithEmailPassword(
      {required String email, required String password}) async {
    //TODO: handle firebase or other authentication protocol here
    Map<String, dynamic> result = {
      "email": email,
      "userId": email,
      "userName": "unkownuser1",
      "fullName": "Johnson Francisco",
      "profilePic": KAssets.primeUserNetworkImage,
    };
    _ref
        .read(localStorageServiceProvider)
        .save(Keys.userId, jsonEncode(result));
    return result;
  }

  Future<(String, String)> fetchOrSaveRememberMeDetails(
      {String email = '', String password = ''}) async {
    if (email.isEmpty) {
      String eeMail = await _ref
          .read(localStorageServiceProvider)
          .fetch(Keys.rememberEmail);
      String ppPass =
          await _ref.read(localStorageServiceProvider).fetch(Keys.rememberPass);
      return (eeMail, ppPass);
    } else {
      _ref.read(localStorageServiceProvider).save(Keys.rememberEmail, email);
      _ref.read(localStorageServiceProvider).save(Keys.rememberPass, password);
      return ('', '');
    }
  }

  Future<String> fetchCurrentUser() async {
    String uid =
        await _ref.read(localStorageServiceProvider).fetch(Keys.userId);
    return uid;
  }
}
