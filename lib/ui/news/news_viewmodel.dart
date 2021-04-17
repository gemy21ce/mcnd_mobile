import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:mcnd_mobile/data/models/app/news_post_with_media.dart';
import 'package:mcnd_mobile/services/news_service.dart';

@injectable
class NewsViewModel extends StateNotifier<AsyncValue<List<NewsPostWithMedia>>> {
  final NewsService _newsService;
  final Logger _logger;

  NewsViewModel(this._newsService, this._logger) : super(const AsyncValue.loading());

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final res = await _newsService.getNewsPosts();
      state = AsyncValue.data(res);
    } catch (e, stk) {
      _logger.e('Loading news posts failed', e, stk);
      state = AsyncValue.error(e, stk);
    }
  }
}
