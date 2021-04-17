import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_media.freezed.dart';

@freezed
class FeaturedMedia with _$FeaturedMedia {
  const factory FeaturedMedia({
    required String fullImageUrl,
    required String thumbnailImageUrl,
  }) = _FeaturedMedia;
}
