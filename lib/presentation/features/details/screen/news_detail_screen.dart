import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';
import 'package:aibuzz_newsapp/presentation/features/boomarks/bloc/saved_articles_bloc.dart';
import 'package:aibuzz_newsapp/presentation/features/details/widgets/detail_headline.dart';
import 'package:aibuzz_newsapp/presentation/features/details/widgets/detail_source_date.dart';

import 'package:aibuzz_newsapp/presentation/features/details/widgets/details_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    DateTime dateTime = DateTime.tryParse(widget.newsDate) ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          // 🔹 Top Image
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),

          // 🔹 Content Card
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                DetailHeadline(text: widget.newsTitle),
                SizedBox(height: height * .02),
                DetailSourceDate(
                  source: widget.source,
                  date: format.format(dateTime),
                ),
                SizedBox(height: height * .12),
                DetailDescription(text: widget.description),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final article = ArticleEntity(
            title: widget.newsTitle,
            description: widget.description,
            urlToImage: widget.newImage,
            source: widget.source,
            publishedAt: widget.newsDate,
          );
          context.read<SavedArticlesBloc>().add(SaveArticle(article));
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Article Saved")));
        },
        child: const Icon(Icons.bookmark, color: Colors.black),
      ),
    );
  }
}
