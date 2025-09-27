import 'dart:convert';

import 'package:aibuzz_newsapp/data/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/data/model/news_channels_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=69a5a91352d040f18f8bb51c9620cb11';

    // all news
    /*         'https://newsapi.org/v2/top-headlines/sources=&apiKey=69a5a91352d040f18f8bb51c9620cb11'; */
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception("Error");
    }
  }

  Future<CaterogiesNewsModel> fetchCategoriesNewsApi(String catergory) async {
    String url =
        'https://newsapi.org/v2/everything?q=${catergory}&apiKey=69a5a91352d040f18f8bb51c9620cb11';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CaterogiesNewsModel.fromJson(body);
    } else {
      throw Exception("Error");
    }
  }
}
