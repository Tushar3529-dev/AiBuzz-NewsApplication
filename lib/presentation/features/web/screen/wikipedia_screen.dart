import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikipediaScreen extends StatefulWidget {
  const WikipediaScreen({super.key});

  @override
  State<WikipediaScreen> createState() => _WikipediaScreenState();
}

class _WikipediaScreenState extends State<WikipediaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.wikipedia.org"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wikipedia")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
