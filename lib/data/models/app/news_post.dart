import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';

part 'news_post.freezed.dart';

@freezed
class NewsPost with _$NewsPost {
  const factory NewsPost({
    required String title,
    required DateTime date,
    required String excerpt,
    required String content,
    FeaturedMedia? featuredMedia,
  }) = _NewsPost;
}
