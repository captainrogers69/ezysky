
// final remoteConfigProvider = Provider<FirebaseRemoteConfig>((ref) {
//   return FirebaseRemoteConfig.instance;
// });

// final remoteServiceProvider = Provider<RemoteService>((ref) {
//   return RemoteService(ref);
// });

/* class RemoteService {
  final Ref _ref;
  RemoteService(this._ref);

  /// Prime Function to fetch Update Status
  Future<void> checkForUpdate() async {
    try {
      await Future.delayed(Duration.zero);
      await _ref.read(remoteConfigProvider).setConfigSettings(
            RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 20),
              minimumFetchInterval: const Duration(seconds: 0),
            ),
          );

      // const info = getUpdateAvailability();
      Availability updateAvailability = await getUpdateAvailability();

      final text = switch (updateAvailability) {
        UpdateAvailable() => "There's an update available!",
        NoUpdateAvailable() => "There's no update available!",
        UnknownAvailability() =>
          "Sorry, couldn't determine if there is or not an available update!",
      };

      if (Platform.isAndroid) {
        await redirectUpdateAndroid(
            updateAvailable: text == "There's an update available!");
      } else {
        redirectUpdateiOS(
            updateAvailable: text == "There's an update available!");
      }
    } catch (e) {
      log("error: $e", name: "RemoteService");
    }
  }

  /// Prime Function to fetch Restrictions
  Future<void> checkforRestriction() async {
    await Future.delayed(Duration.zero);
    await _ref.read(remoteConfigProvider).setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 20),
            minimumFetchInterval: const Duration(seconds: 0),
          ),
        );

    bool restrictionAvailable = await checkFirebaseRemoteConfigForRestriction();
    if (restrictionAvailable) {
      await redirectRestriction(block: restrictionAvailable);
    } else {
      log("no restrictions",name: "RemoteService");
    }
  }


  /// Restriction dialog
  Future<void> redirectRestriction({required bool block}) async {
    _ref.read(dialogProvider).openDialog(
          barrierDismissible: false,
          dialog: WillPopScope(
            onWillPop: () => Future.value(false),
            child: KAlertDialog(
              title: "Error",
              actiontitle: "Contact Admin",
              subtitle: "Something went wrong",
              onAction: () {},
              onCancel: () {},
              canceltitle: "Ask Later",
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    "Contact Admin",
                    style: Kstyles.kButtonStyle.copyWith(
                      color: KColors.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
  }
} */