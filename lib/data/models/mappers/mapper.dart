import 'package:injectable/injectable.dart';
import 'package:mcnd_mobile/data/models/mappers/api_news_post_mapper.dart';
import 'package:mcnd_mobile/data/models/mappers/api_prayer_time_mapper.dart';

export 'api_prayer_time_mapper.dart';

@injectable
class Mapper with ApiPrayerTimeMapper, ApiNewsPostMapper {
  const Mapper();
}
