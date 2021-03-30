import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/api/prayer_time_filter.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';
import 'package:mcnd_mobile/data/network/mcnd_api.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';

@injectable
class PrayerTimesViewModel extends StateNotifier<PrayerTimesModel> {
  final McndApi _api;
  final Mapper _mapper;

  PrayerTimesViewModel(this._api, this._mapper)
      : super(PrayerTimesModel.loading());

  void fetchTimes() async {
    state = PrayerTimesModel.loading();
    try {
      final apiModel = (await _api.getPrayerTime(PrayerTimeFilter.TODAY)).first;
      final prayerTimes = _mapper.mapApiPrayerTime(apiModel);
      state = PrayerTimesModel.loaded(prayerTimes);
    } catch (e) {
      state = PrayerTimesModel.error(e.toString());
    }
  }
}
