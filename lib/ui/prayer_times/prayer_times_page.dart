import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';

class PrayerTimesPage extends HookWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = useProvider(prayerTimesViewModelProvider);
    useEffect(() {
      viewmodel.fetchTimes();
    }, []);
    final state = useProvider(prayerTimesViewModelProvider.state);
    return state.when(
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
      error: (error) => Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
      loaded: (prayerTimes) {
        return Text(
          "Loaded",
          style: TextStyle(color: Colors.red),
        );
      },
    );
  }
}
