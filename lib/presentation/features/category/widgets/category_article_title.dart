import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoryArticleTile extends StatelessWidget {
  final categoriesModel.Articles article;
  final double width, height;
  final DateFormat format;
  final Widget spinKit;

  const CategoryArticleTile({
    super.key,
    required this.article,
    required this.width,
    required this.height,
    required this.format,
    required this.spinKit,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage ?? "";
    final dateTime =
        DateTime.tryParse(article.publishedAt ?? "") ?? DateTime.now();

    return InkWell(
      onTap: () => _openDetail(context, article),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: height * .18,
                width: width * .3,
                placeholder: (context, url) => Center(child: spinKit),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline, color: Colors.red),
              ),
            ),
            Expanded(
              child: Container(
                height: height * .18,
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Text(
                      article.title ?? "",
                      maxLines: 3,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          article.source?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          format.format(dateTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, categoriesModel.Articles article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          newImage: article.urlToImage ?? "",
          newsTitle: article.title ?? "",
          newsDate: article.publishedAt ?? "",
          author: article.author ?? "",
          description: article.description ?? "",
          content: article.content ?? "",
          source: article.source?.name ?? "",
        ),
      ),
    );
  }
}
