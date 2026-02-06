import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/api/api_status.dart';
import '/data/models/guests_model.dart';
import '/data/source/dummy_source.dart';

final guestsListingRepoProvider = Provider<GuestsListingRepository>((ref) {
  return GuestsListingRepository(/* ref */);
});

abstract class BaseGuestsListingRepository {
  Future<ApiStatus<List<GuestsModel>>> fetchGuestsListing();
}

class GuestsListingRepository implements BaseGuestsListingRepository {
  /* final Ref _ref; */
  GuestsListingRepository(/* this._ref */);

  static bool enabledLogs = true;

  void apilog(String data, {required String name}) {
    if (enabledLogs) {
      log(data, name: "GuestsListingRepository - $name");
    }
  }

  /* Future<ApiStatus<List<GuestsModel>>> fetchGuestsListing() async {
    try {
      final response = await _ref.read(apiServiceProvider).sendGraphQlRequest(
            query: _ref.read(guestsQueryProvider).fetchGuestsListing,
          );
      apilog('${response.statusCode} :: ${response.data}',
          name: "fetchGuestsListing - response");

      if (response.statusCode == 200) {
        fetchGuestsListingModel model =
            fetchGuestsListingModel.fromJson(response.data);
        if (model.data?.getMyAddresses?.success == true) {
          apilog('${model.toJson()}', name: "fetchGuestsListing - success");
          return ApiStatus.success(data: model);
        } else {
          apilog('${model.toJson()}',
              name: "fetchGuestsListing - else of success");
          return ApiStatus.error(
              error: model.data?.getMyAddresses?.message ??
                  "Something went wrong");
        }
      } else {
        apilog('something wen twrong', name: "fetchGuestsListing - else of 200");
        return ApiStatus.error(error: "Something went wrong");
      }
    } on DioException catch (e) {
      apilog('$e', name: "fetchGuestsListing - dioexeption");
      return ApiStatus.error(error: "Something went wrong");
    } catch (e) {
      apilog('$e', name: "fetchGuestsListing - catch");
      return ApiStatus.error(error: "Something went wrong");
    }
  } */

  /// [ONLY DUMMY DATA - CHECK API CALL BELOW THIS FUNCTION👇🏻]
  @override
  Future<ApiStatus<List<GuestsModel>>> fetchGuestsListing() async {
    try {
      // 1. call api, filter response - 200, success, else

      /// [dummy till any api availability]
      List<GuestsModel> result = DummySource.guestsList;
      return ApiStatus.success(data: result);
    } catch (e) {
      apilog('$e', name: "fetchGuestsListing - catch");
      return ApiStatus.error(error: "Something went wrong");
    }
  }
}
