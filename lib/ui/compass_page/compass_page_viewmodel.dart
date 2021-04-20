import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

import 'compass_page_model.dart';

@injectable
class CompassPageViewModel extends StateNotifier<CompassPageModel> {
  CompassPageViewModel() : super(const CompassPageModel.initial());

  Future<void> load([PermissionStatus? permissionStatus]) async {
    final locationPermissionStatus = permissionStatus ?? await Permission.locationWhenInUse.status;
    if (locationPermissionStatus.isGranted) {
      state = const CompassPageModel.permissionGranted();
    } else if (locationPermissionStatus.isDenied) {
      state = const CompassPageModel.permissionNotGranted();
    } else {
      state = const CompassPageModel.permissionPermanentlyDenied();
    }
  }

  Future<void> grantPermission() async {
    final locationPermissionStatus = await Permission.locationWhenInUse.request();
    if (locationPermissionStatus.isPermanentlyDenied) {
      await openSettingsPage();
    }
    load(locationPermissionStatus);
  }

  Future<void> openSettingsPage() async {
    await permission_handler.openAppSettings();
  }
}
