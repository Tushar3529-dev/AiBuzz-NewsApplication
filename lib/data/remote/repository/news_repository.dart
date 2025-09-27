import 'dart:convert';

import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/data/remote/model/news_channels_headlines_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
    String newsChannel,
  ) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=074d777887214eabb5152ff0b2ab8c41';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception("My Account limit Hit");
    }
  }

  Future<CaterogiesNewsModel> fetchCategoriesNewsApi(String catergory) async {
    String url =
        'https://newsapi.org/v2/everything?q=${catergory}&apiKey=074d777887214eabb5152ff0b2ab8c41';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CaterogiesNewsModel.fromJson(body);
    } else {
      throw Exception("My Account limit Hit");
    }
  }
}
