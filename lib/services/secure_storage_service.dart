import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService(ref);
});

class Keys {
  // static String isIntroShown = 'SECOND_VISIT';
  static String userId = 'USER_ID';
  static const String rememberEmail = 'REM_EMAIL';
  static const String rememberPass = 'REM_PASS';
  // static String accessToken = 'ACCESS_TOKEN';
  // static String refreshToken = 'REFRESH_TOKEN';
}

class LocalStorageService {
  final Ref _ref;
  LocalStorageService(this._ref);

  void save(String key, String value) {
    _ref.read(secureStorageProvider).write(key: key, value: value);
  }

  void clear(String key) {
    _ref.read(secureStorageProvider).delete(key: key);
  }

  Future<String> fetch(String key) async {
    return await _ref.read(secureStorageProvider).read(key: key) ?? '';
  }

  void clearAll() {
    _ref.read(secureStorageProvider).deleteAll();
  }
}
