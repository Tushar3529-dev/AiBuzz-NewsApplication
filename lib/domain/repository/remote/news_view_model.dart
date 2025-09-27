import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/data/remote/model/news_channels_headlines_model.dart';
import 'package:aibuzz_newsapp/data/remote/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
    String newsChannel,
  ) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(newsChannel);
    return response;
  }

  Future<CaterogiesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
