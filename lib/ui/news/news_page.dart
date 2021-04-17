import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcnd_mobile/core/utils/datetime_utils.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';
import 'package:mcnd_mobile/data/models/app/news_post.dart';
import 'package:mcnd_mobile/data/models/app/news_post_with_media.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/mcnd_router.gr.dart';
import 'package:mcnd_mobile/ui/shared/hooks/use_once.dart';
import 'package:mcnd_mobile/ui/shared/widget/async_value_builder.dart';

final _dateFormat = DateFormat('MMMM dd, yyyy');

class NewsPage extends HookWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(newsViewModelProvider);
    useOnce(() => viewModel.load());
    final state = useProvider(newsViewModelProvider.state);
    return AsyncValueBuilder<List<NewsPostWithMedia>>(
      value: state,
      builder: (posts) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index].post;
            final media = posts[index].media;
            return NewsItem(post: post, media: media);
          },
        );
      },
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.post,
    required this.media,
  }) : super(key: key);

  final NewsPost post;
  final FeaturedMedia media;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(NewsPostDetailsScreenRoute(post: post, media: media));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              post.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              post.date.format(_dateFormat),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CachedNetworkImage(
                      imageUrl: media.thumbnailImageUrl,
                      width: 100,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, dynamic error) => const Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Html(
                      data: post.excerpt,
                      style: {
                        'p': Style(
                          fontSize: FontSize.rem(0.85),
                          textAlign: TextAlign.justify,
                        )
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
