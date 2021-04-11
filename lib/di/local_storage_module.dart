import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/local/settings.dart';

@module
abstract class LocalStorageModule {
  @singleton
  @preResolve
  Future<Box<Settings>> getSettingsBox() => Hive.openBox<Settings>('settings');
}
