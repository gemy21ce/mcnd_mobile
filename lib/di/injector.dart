import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/di/injector.config.dart';

final injector = GetIt.I;

@InjectableInit()
Future<void> initializeInjector() async =>
    // ignore: await_only_futures, unnecessary_await_in_return
    await $initGetIt(injector);
