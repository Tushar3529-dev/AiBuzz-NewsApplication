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
  final String newImage;
  final String newsTitle;
  final String newsDate;
  final String author;
  final String description;
  final String content;
  final String source;
  final String url;

  const NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
    required this.url,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    //  Safely parse date
    final dateTime = DateTime.tryParse(widget.newsDate) ?? DateTime.now();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          //  Top Image
          Hero(
            tag: widget.url,
            child: SizedBox(
              height: height * 0.45,
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
            ),
          ),

          //  Content Card
          Container(
            height: height * .65,
            margin: EdgeInsets.only(top: height * .38),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                const SizedBox(height: 12),
                DetailSourceDate(
                  source: widget.source,
                  date: format.format(dateTime),
                ),
                const SizedBox(height: 24),
                DetailDescription(text: widget.description),
                const SizedBox(height: 16),
                if (widget.content.isNotEmpty)
                  Text(
                    widget.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
              ],
            ),
          ),
        ],
      ),

      //  Floating Bookmark Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          final article = ArticleEntity(
            title: widget.newsTitle,
            description: widget.description,
            urlToImage: widget.newImage,
            source: widget.source,
            publishedAt: widget.newsDate,
            url: widget.url,
            author: widget.author,
            content: widget.content,
          );

          context.read<SavedArticlesBloc>().add(SaveArticle(article));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Article Saved to Bookmarks")),
          );
        },
        child: const Icon(Icons.bookmark, color: Colors.black),
      ),
    );
  }
}
