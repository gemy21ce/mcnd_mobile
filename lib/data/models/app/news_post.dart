import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_post.freezed.dart';

@freezed
class NewsPost with _$NewsPost {
  const factory NewsPost({
    required String title,
    required DateTime date,
    required String excerpt,
    required String content,
  }) = _NewsPost;
}
