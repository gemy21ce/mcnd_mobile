import 'package:freezed_annotation/freezed_annotation.dart';

part 'compass_page_model.freezed.dart';

@freezed
class CompassPageModel with _$CompassPageModel {
  const factory CompassPageModel.initial() = Inital;
  const factory CompassPageModel.permissionNotGranted() = PermissionNotGranted;
  const factory CompassPageModel.permissionPermanentlyDenied() = PermissionPermanentlyDenied;
  const factory CompassPageModel.permissionGranted() = PermissionGranted;
}
