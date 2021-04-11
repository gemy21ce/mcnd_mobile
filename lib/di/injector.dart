import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/di/injector.config.dart';

class Injector {
  Injector._();

  static Injector? _instance;

  factory Injector.getInstance() {
    return _instance ??= Injector._();
  }

  final _locator = GetIt.I;

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (!_initialized) {
      await _configureDependencies(_locator);
      _initialized = true;
    }
  }

  D get<D extends Object>({dynamic param1, dynamic param2}) => _locator.get<D>(
        param1: param1,
        param2: param2,
      );
}

@InjectableInit()
Future<void> _configureDependencies(GetIt locator) async =>
    // ignore: await_only_futures, unnecessary_await_in_return
    await $initGetIt(locator);
