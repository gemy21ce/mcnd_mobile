import 'package:flutter_test/flutter_test.dart';
import 'package:mcnd_mobile/data/models/api/api_featured_media.dart';
import 'package:mcnd_mobile/data/models/api/api_news_post.dart';
import 'package:mcnd_mobile/data/models/mappers/mapper.dart';

import '../../../_test_shared/api_response.dart';

void main() {
  test('mapApiNewsPost with no media', () {
    final apiRes = ApiNewsPost.fromJson(apiNewsPostResponse);
    final mapped = const Mapper().mapApiNewsPost(apiRes);

    expect(mapped.title, apiRes.title.rendered);
    expect(mapped.content, apiRes.content.rendered);
    expect(mapped.excerpt, apiRes.excerpt.rendered);
    expect(mapped.date, apiRes.date);
    expect(mapped.featuredMedia, null);
  });

  test('mapApiNewsPost will parse media', () {
    final apiRes = ApiNewsPost.fromJson(apiNewsPostResponse);
    final mediaApiRes = ApiFeaturedMedia.fromJson(apiMediaResponse);
    final mapped = const Mapper().mapApiNewsPost(apiRes, mediaApiRes);
    final mappedMedia = const Mapper().mapApiFeaturedMedia(mediaApiRes);

    expect(mapped.featuredMedia, isNot(equals(null)));
    expect(mapped.featuredMedia, equals(mappedMedia));
  });

  test('mapApiFeaturedMedia', () {
    final apiRes = ApiFeaturedMedia.fromJson(apiMediaResponse);
    final mapped = const Mapper().mapApiFeaturedMedia(apiRes)!;

    expect(mapped.thumbnailImageUrl, apiRes.mediaDetails?.sizes?.thumbnail?.sourceUrl);
    expect(mapped.fullImageUrl, apiRes.mediaDetails?.sizes?.full?.sourceUrl);
  });
}
