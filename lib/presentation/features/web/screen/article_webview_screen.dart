import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebViewScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleWebViewScreen({super.key, required this.article});

  @override
  State<ArticleWebViewScreen> createState() => _ArticleWebViewScreenState();
}

class _ArticleWebViewScreenState extends State<ArticleWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.article.url ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.source),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // ✅ Hook up to SavedArticlesBloc later
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Article saved for later")),
              );
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
