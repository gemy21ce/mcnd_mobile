import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcnd_mobile/data/models/mcnd_datetime_converter.dart';

part 'api_news_post.freezed.dart';
part 'api_news_post.g.dart';

@freezed
class ApiNewsPost with _$ApiNewsPost {
  factory ApiNewsPost({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'date') @McndDateTimeConverter() required DateTime date,
    @JsonKey(name: 'title') required ApiNewsPostRendered title,
    @JsonKey(name: 'content') required ApiNewsPostRendered content,
    @JsonKey(name: 'excerpt') required ApiNewsPostRendered excerpt,
    @JsonKey(name: 'featured_media') required int featuredMedia,
  }) = _NewsPost;

  factory ApiNewsPost.fromJson(Map<String, dynamic> json) => _$ApiNewsPostFromJson(json);
}

@freezed
class ApiNewsPostRendered with _$ApiNewsPostRendered {
  factory ApiNewsPostRendered({
    @JsonKey(name: 'rendered') required String rendered,
  }) = _ApiNewsPostRendered;

  factory ApiNewsPostRendered.fromJson(Map<String, dynamic> json) => _$ApiNewsPostRenderedFromJson(json);
}
