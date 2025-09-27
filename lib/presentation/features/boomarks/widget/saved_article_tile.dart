import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';
import 'package:aibuzz_newsapp/presentation/features/boomarks/bloc/saved_articles_bloc.dart';
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SavedArticleTile extends StatelessWidget {
  final ArticleEntity article;
  final int index;
  final double width;
  final double height;
  final DateFormat format;

  const SavedArticleTile({
    super.key,
    required this.article,
    required this.index,
    required this.width,
    required this.height,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage ?? "";
    final dateTime = DateTime.tryParse(article.publishedAt) ?? DateTime.now();

    return InkWell(
      onTap: () {
        // ✅ Navigate to NewsDetailScreen using saved data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsDetailScreen(
              newImage: article.urlToImage ?? "",
              newsTitle: article.title,
              newsDate: article.publishedAt,
              author: article.author ?? "Unknown",
              description: article.description ?? "",
              content: article.content ?? "",
              source: article.source,
              url: article.url ?? "",
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Row(
          children: [
            // 🔹 Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: height * .18,
                width: width * .3,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline, color: Colors.red),
              ),
            ),
            const SizedBox(width: 12),

            // 🔹 Title + Source + Date
            Expanded(
              child: SizedBox(
                height: height * .18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.source,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          format.format(dateTime),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 Delete Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<SavedArticlesBloc>().add(DeleteArticle(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}
