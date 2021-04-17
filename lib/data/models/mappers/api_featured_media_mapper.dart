import 'package:mcnd_mobile/data/models/api/api_featured_media.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

mixin ApiFeaturedMediaMapper {
  FeaturedMedia mapApiFeaturedMedia(ApiFeaturedMedia apiFeaturedMedia) {
    return FeaturedMedia(
      fullImageUrl: apiFeaturedMedia.mediaDetails.sizes.full.sourceUrl,
      thumbnailImageUrl: apiFeaturedMedia.mediaDetails.sizes.thumbnail.sourceUrl,
    );
  }
}
