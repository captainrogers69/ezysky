import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:squareboat/data/models/whether_model.dart';
import 'package:squareboat/data/repositories/whether_repository.dart';
import 'package:squareboat/services/routing_service.dart';

final homeWhetherNotifier = ChangeNotifierProvider<_HomeWhetherNotifier>((ref) {
  return _HomeWhetherNotifier(ref);
});

class _HomeWhetherNotifier extends ChangeNotifier {
  final Ref _ref;
  _HomeWhetherNotifier(this._ref);

  (Position?, String)? _userLocation;
  (Position?, String)? get userLocation => _userLocation;

  void configuserLocation(
      {required Position? state, required String formattedAddress}) {
    _userLocation = (state, formattedAddress);
    notifyListeners();
    fetchWhether(cityName: formattedAddress);
  }

  bool _fetchingWhether = false;
  bool get fetchingWhether => _fetchingWhether;

  void configFetchingWhether({required bool state}) {
    _fetchingWhether = state;
    notifyListeners();
  }

  WhetherResponse? _cityWhetherResponse;
  WhetherResponse? get cityWhetherResponse => _cityWhetherResponse;

  Future<void> fetchWhether({required String cityName}) async {
    configFetchingWhether(state: true);
    // fetch api here
    WhetherResponse? response =
        await _ref.read(whetherRepoProvider).fetchWhether(cityName: cityName);
    _cityWhetherResponse = response;
    log("here is the data for whethere ${response?.toJson()}");
    configFetchingWhether(state: false);
    _ref.read(routingService).pop();
  }
}
