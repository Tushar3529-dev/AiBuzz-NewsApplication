import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:flutter/material.dart';

class OpenDetailScreen {
  static void open(BuildContext context, dynamic article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          newImage: article.urlToImage ?? "",
          newsTitle: article.title ?? "",
          newsDate: article.publishedAt ?? "",
          author: article.author ?? "Unknown",
          description: article.description ?? "",
          content: article.content ?? "",
          source: article.source?.name ?? "",
          url: article.url ?? "",
        ),
      ),
    );
  }
}
