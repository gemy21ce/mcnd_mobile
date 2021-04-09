import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/mappers/api_prayer_time_mapper.dart';

export 'api_prayer_time_mapper.dart';

@injectable
class Mapper with MapperPrayerTime {
  const Mapper();
}
