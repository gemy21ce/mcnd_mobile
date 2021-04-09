import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/di/injector.config.dart';

class Injector {
  Injector._();

  static Injector? _instance;

  factory Injector.getInstance() {
    return _instance ??= Injector._().._init();
  }

  final _locator = GetIt.I;

  Future<void> _init() async {
    await _configureDependencies(_locator);
  }

  D get<D extends Object>({dynamic param1, dynamic param2}) => _locator.get<D>(
        param1: param1,
        param2: param2,
      );
}

@InjectableInit()
Future<void> _configureDependencies(GetIt locator) async =>
    // ignore: await_only_futures
    await $initGetIt(locator);
