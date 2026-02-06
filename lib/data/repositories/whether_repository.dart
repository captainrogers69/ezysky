import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:squareboat/data/manager/dio_methods.dart';
import 'package:squareboat/data/manager/dio_wrapper.dart';
import 'package:squareboat/data/models/whether_model.dart';

class BaseWhetherRepository {}

final whetherRepoProvider = Provider<_WhetherRepository>((ref) {
  return _WhetherRepository(ref);
});

class _WhetherRepository implements BaseWhetherRepository {
  final Ref _ref;
  _WhetherRepository(this._ref);

  static bool enabledLogs = true;

  void apilog(String data, {required String name}) {
    if (enabledLogs) {
      log(data, name: "_WhetherRepository - $name");
    }
  }

  Future<WhetherResponse?> fetchWhether({required String cityName}) async {
    Map<String, dynamic> params = {};
    WhetherResponse? result;
    try {
      await _ref.read(dioWrapperProvider).request(
            onResponse: (response, error) {
              if (response != null) {
                // apilog("$response \n ${response.runtimeType}", name: "fetchWhether");
                result = WhetherResponse.fromJson(response);
              } else {
                // apilog("$response \n ${response.runtimeType}",
                //     name: "fetchWhether error");
              }
            },
            headers: {},
            endPoint:
                "https://api.weatherapi.com/v1/current.json?key=80c2c886daa64568a79111825260602&q=$cityName&aqi=yes",
            method: DioMethod.getr,
            params: params,
          );
      // log("res: res red ${result.length}");
    } catch (e) {
      apilog("$e", name: "fetchWhether");
    }
    return result;
  }
}
