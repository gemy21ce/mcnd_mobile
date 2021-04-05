import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/injector.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_viewmodel.dart';

final injectorProvider = Provider<Injector>((ref) => Injector.getInstance());

final prayerTimesViewModelProvider =
    StateNotifierProvider<PrayerTimesViewModel>((ref) {
  final injector = ref.read(injectorProvider);
  return injector.get();
});
