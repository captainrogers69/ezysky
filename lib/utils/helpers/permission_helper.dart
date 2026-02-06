import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<bool> getPermission(
      {required Future<bool> Function() showSettingsDialog,
      required PermissionWithService permissions}) async {
    // 1. Check current permission status
    final status = await permissions.status;

    if (status.isGranted) {
      // Permission already granted
      return true;
    } else if (status.isDenied || status.isRestricted) {
      // Request permission

      final result = await Permission.location.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        // 2. Show dialog to open settings
        await showSettingsDialog();
        return false;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      // 2. Show dialog to open settings
      await showSettingsDialog();
      return false;
    }
    return false;
  }

  static Future<bool> getMultipleNamedPermissions({
    required Future<bool> Function() showSettingsDialog,
    required List<Permission> requiredPermissions,
    required List<PermissionWithService> requiredPermissionService,
  }) async {
    bool allGranted = true;
    bool anyPermanentlyDenied = false;

    // Check normal permissions
    for (final permission in requiredPermissions) {
      final status = await permission.status;
      final requestResult = await permission.request();

      if (status.isGranted) {
        continue;
      } else if (status.isDenied || status.isRestricted) {
        if (!requestResult.isGranted) {
          if (requestResult.isPermanentlyDenied) {
            anyPermanentlyDenied = true;
          }
          allGranted = false;
        }
      } else if (status.isPermanentlyDenied) {
        anyPermanentlyDenied = true;
        allGranted = false;
      } else {
        allGranted = false;
      }
    }

    // Check permissions with service
    for (final permission in requiredPermissionService) {
      final status = await permission.status;
      final requestResult = await permission.request();

      if (status.isGranted) {
        continue;
      } else if (status.isDenied || status.isRestricted) {
        if (!requestResult.isGranted) {
          if (requestResult.isPermanentlyDenied) {
            anyPermanentlyDenied = true;
          }
          allGranted = false;
        }
      } else if (status.isPermanentlyDenied) {
        anyPermanentlyDenied = true;
        allGranted = false;
      } else {
        allGranted = false;
      }
    }

    if (anyPermanentlyDenied) {
      await showSettingsDialog();
    }

    return allGranted;
  }
}
