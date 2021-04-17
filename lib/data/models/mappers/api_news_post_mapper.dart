import 'package:mcnd_mobile/data/models/api/api_news_post.dart';
import 'package:mcnd_mobile/data/models/app/news_post.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

mixin ApiNewsPostMapper {
  NewsPost mapApiNewsPost(ApiNewsPost apiNewsPost) {
    return NewsPost(
      title: apiNewsPost.title.rendered,
      date: apiNewsPost.date,
      excerpt: apiNewsPost.excerpt.rendered,
      content: apiNewsPost.content.rendered,
    );
  }
}
