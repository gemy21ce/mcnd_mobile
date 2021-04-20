import 'package:mcnd_mobile/data/models/api/api_featured_media.dart';
import 'package:mcnd_mobile/data/models/api/api_news_post.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';
import 'package:mcnd_mobile/data/models/app/news_post.dart';

mixin ApiNewsPostMapper {
  NewsPost mapApiNewsPost(ApiNewsPost apiNewsPost, [ApiFeaturedMedia? apiFeaturedMedia]) {
    return NewsPost(
        title: apiNewsPost.title.rendered,
        date: apiNewsPost.date,
        excerpt: apiNewsPost.excerpt.rendered,
        content: apiNewsPost.content.rendered,
        featuredMedia: mapApiFeaturedMedia(apiFeaturedMedia));
  }

  FeaturedMedia? mapApiFeaturedMedia(ApiFeaturedMedia? apiFeaturedMedia) {
    if (apiFeaturedMedia == null) return null;
    return FeaturedMedia(
      fullImageUrl: apiFeaturedMedia.mediaDetails?.sizes?.full?.sourceUrl,
      thumbnailImageUrl: apiFeaturedMedia.mediaDetails?.sizes?.thumbnail?.sourceUrl,
    );
  }
}
