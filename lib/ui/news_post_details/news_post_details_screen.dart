import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mcnd_mobile/data/models/app/featured_media.dart';
import 'package:mcnd_mobile/data/models/app/news_post.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (controller) {
            controller.loadUrl(Uri.dataFromString(
              post.content,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString());
          },
        ),
      ),
    );
  }
}
