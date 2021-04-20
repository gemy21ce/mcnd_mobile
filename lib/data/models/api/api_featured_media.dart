import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_featured_media.freezed.dart';
part 'api_featured_media.g.dart';

@freezed
class ApiFeaturedMedia with _$ApiFeaturedMedia {
  const factory ApiFeaturedMedia({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'media_details') ApiFeaturedMediaDetails? mediaDetails,
  }) = _ApiFeaturedMedia;

  factory ApiFeaturedMedia.fromJson(Map<String, dynamic> json) => _$ApiFeaturedMediaFromJson(json);
}

@freezed
class ApiFeaturedMediaDetails with _$ApiFeaturedMediaDetails {
  const factory ApiFeaturedMediaDetails({
    @JsonKey(name: 'sizes') ApiFeaturedMediaDetailsSizes? sizes,
  }) = _ApiFeaturedMediaDetails;

  factory ApiFeaturedMediaDetails.fromJson(Map<String, dynamic> json) => _$ApiFeaturedMediaDetailsFromJson(json);
}

@freezed
class ApiFeaturedMediaDetailsSizes with _$ApiFeaturedMediaDetailsSizes {
  const factory ApiFeaturedMediaDetailsSizes({
    @JsonKey(name: 'full') ApiFeaturedMediaDetailsSize? full,
    @JsonKey(name: 'thumbnail') ApiFeaturedMediaDetailsSize? thumbnail,
  }) = _ApiFeaturedMediaDetailsSizes;

  factory ApiFeaturedMediaDetailsSizes.fromJson(Map<String, dynamic> json) =>
      _$ApiFeaturedMediaDetailsSizesFromJson(json);
}

@freezed
class ApiFeaturedMediaDetailsSize with _$ApiFeaturedMediaDetailsSize {
  const factory ApiFeaturedMediaDetailsSize({
    @JsonKey(name: 'source_url') String? sourceUrl,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
  }) = _ApiFeaturedMediaDetailsSize;

  factory ApiFeaturedMediaDetailsSize.fromJson(Map<String, dynamic> json) =>
      _$ApiFeaturedMediaDetailsSizeFromJson(json);
}
