import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/mappers/api_prayer_time_mapper.dart';
import 'package:mcnd_mobile/data/models/mappers/list_mapper.dart';

export 'api_prayer_time_mapper.dart';
export 'list_mapper.dart';

@injectable
class Mapper with MapperList, MapperPrayerTime {
  const Mapper();
}
