import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';
import 'package:flutter_html/src/layout_element.dart';
import 'package:flutter_html/style.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';
import 'package:mcnd_mobile/data/models/app/news_post.dart';

class NewsPostDetailsScreen extends StatelessWidget {
  final NewsPost post;
  final FeaturedMedia media;

  const NewsPostDetailsScreen({
    required this.post,
    required this.media,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          post.title,
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Html(
          shrinkWrap: true,
          data: post.content,
          style: {
            '*': Style(
              fontSize: FontSize.rem(0.85),
              textAlign: TextAlign.justify,
            )
          },
          customImageRenders: {
            networkSourceMatcher(): (context, attributes, element) {
              attributes.remove('width');
              attributes.remove('height');
              return networkImageRender()(context, attributes, element);
            },
          },
          customRender: {
            'table': (context, parsedChild) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: (context.tree as TableLayoutElement).toWidget(context),
              );
            }
          },
        ),
      ),
    );
  }
}
