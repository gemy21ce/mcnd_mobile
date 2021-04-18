import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';

import 'news_post.dart';

part 'news_post_with_media.freezed.dart';

@freezed
class NewsPostWithMedia with _$NewsPostWithMedia {
  const factory NewsPostWithMedia(
    NewsPost post,
    FeaturedMedia media,
  ) = _NewsPostWithMedia;
}
