import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_featured_media.freezed.dart';
part 'api_featured_media.g.dart';

@freezed
class ApiFeaturedMedia with _$ApiFeaturedMedia {
  const factory ApiFeaturedMedia({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'media_details') required ApiFeaturedMediaDetails mediaDetails,
  }) = _ApiFeaturedMedia;

  factory ApiFeaturedMedia.fromJson(Map<String, dynamic> json) => _$ApiFeaturedMediaFromJson(json);
}

@freezed
class ApiFeaturedMediaDetails with _$ApiFeaturedMediaDetails {
  const factory ApiFeaturedMediaDetails({
    @JsonKey(name: 'sizes') required ApiFeaturedMediaDetailsSizes sizes,
  }) = _ApiFeaturedMediaDetails;

  factory ApiFeaturedMediaDetails.fromJson(Map<String, dynamic> json) => _$ApiFeaturedMediaDetailsFromJson(json);
}

@freezed
class ApiFeaturedMediaDetailsSizes with _$ApiFeaturedMediaDetailsSizes {
  const factory ApiFeaturedMediaDetailsSizes({
    @JsonKey(name: 'full') required ApiFeaturedMediaDetailsSize full,
    @JsonKey(name: 'thumbnail') required ApiFeaturedMediaDetailsSize thumbnail,
  }) = _ApiFeaturedMediaDetailsSizes;

  factory ApiFeaturedMediaDetailsSizes.fromJson(Map<String, dynamic> json) =>
      _$ApiFeaturedMediaDetailsSizesFromJson(json);
}

@freezed
class ApiFeaturedMediaDetailsSize with _$ApiFeaturedMediaDetailsSize {
  const factory ApiFeaturedMediaDetailsSize({
    @JsonKey(name: 'source_url') required String sourceUrl,
    @JsonKey(name: 'width') required int width,
    @JsonKey(name: 'height') required int height,
  }) = _ApiFeaturedMediaDetailsSize;

  factory ApiFeaturedMediaDetailsSize.fromJson(Map<String, dynamic> json) =>
      _$ApiFeaturedMediaDetailsSizeFromJson(json);
}
