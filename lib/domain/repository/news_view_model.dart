import 'package:aibuzz_newsapp/data/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/data/model/news_channels_headlines_model.dart';
import 'package:aibuzz_newsapp/data/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    final response = await _rep.fetchNewChannelHeadlinesApi();
    return response;
  }

  Future<CaterogiesNewsModel> fetchCategoriesNewsApi(String channelName) async {
    final response = await _rep.fetchCategoriesNewsApi(channelName);
    return response;
  }
}
